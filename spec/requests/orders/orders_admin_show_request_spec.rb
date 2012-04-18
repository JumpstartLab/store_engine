require 'spec_helper'

describe "Orders" do
  let(:product)     { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}
  let(:admin_user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'true') }
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:pending_order)    { Order.create(:user_id => admin_user.id,
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }
  let(:user)    { Fabricate(:user) }
  let!(:order)    { Order.create(:user_id => user.id,
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }



  context "when logged in as an admin" do
    before(:each) do
      pending_order.order_statuses.create(:status => "pending")
      login(admin_user)
      pending_order.order_products << OrderProduct.create(
                              :product_id => product.id,
                              :quantity => 1)
    end

    context "and the order is pending" do
      it "has a field for setting quantity" do
        visit admin_order_path(pending_order)
        within "#order_product_#{pending_order.order_products.last.id}" do
          page.should have_selector(".edit_order_product")
        end
      end
    end

    context "and the order is paid" do
      before(:each) do
        pending_order.order_statuses << OrderStatus.create(:status => "paid")
      end

      it "doesn't show the field for setting quantity" do
        visit admin_order_path(pending_order)
        within "#order_product_#{pending_order.order_products.last.id}" do
          page.should_not have_selector(".edit_order_product")
        end
      end
    end

    context "and the order is paid" do
      it "shows the time the order was marked paid" do
        status = OrderStatus.create(:status => "paid")
        status.created_at = Time.now + 120000000
        status.save
        order.order_statuses << status
        order.save
        visit admin_order_path(order)
        page.should have_content(order.paid_at)
      end
    end

    context "and the order is shipped" do
      it "shows the time the order was marked shipped" do
        status = OrderStatus.create(:status => "shipped")
        status.created_at = Time.now + 130000000
        status.save
        order.order_statuses << status
        order.save
        visit admin_order_path(order)

        page.should have_content(order.shipped_at)
      end
    end

    context "and the order is cancelled" do
      it "shows the time the order was marked cancelled" do
        status = OrderStatus.create(:status => "cancelled")
        status.created_at = Time.now + 140000000
        status.save
        order.order_statuses << status
        order.save
        visit admin_order_path(order)


        page.should have_content(order.cancelled_at)
      end
    end

    context "and the order is returned" do
      it "shows the time the order was marked returned" do
        status = OrderStatus.create(:status => "returned")
        status.created_at = Time.now + 150000000
        status.save
        order.order_statuses << status
        order.save
        visit admin_order_path(order)

        page.should have_content(order.returned_at)
      end
    end

  end
end
