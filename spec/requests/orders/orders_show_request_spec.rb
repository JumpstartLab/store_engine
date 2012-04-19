require 'spec_helper'

describe "Orders" do
  let(:product)     { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}
  let(:user)        { Fabricate(:user) }

  let(:user2)       { Fabricate(:user)}

  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let!(:order)    { Order.create(:user_id => user.id,
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }
  let!(:order2)    { Order.create(:user_id => user2.id,
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }
  let!(:order_product)   { OrderProduct.create(:product_id => product.id,
                                              :order_id => order.id,
                                              :quantity => 3,
                                              :price => product)}

  context "when not logged in" do
    it "prevents you from viewing an order" do
      visit logout_path
      visit order_path(order)

      page.should have_content("First login to access this page.")
    end
  end

  context "when logged in as a user" do

    it "prevents you from viewing another user's order" do
      login(user)
      visit order_path(order2)
      page.should have_content("DON'T TOUCH THAT")
    end

    context "and viewing an order" do
      before(:each) do
        login(user)
        visit order_path(order)
      end

      it "shows the time the order was placed" do
        page.should have_content(order.placed_at)
      end


      context "and the order is pending" do
        it "allows the user to edit the order quantities" do
          visit order_path(order)
          within "#order_product_#{order.order_products.last.id}" do
            page.should have_selector(".edit_order_product")
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
          visit order_path(order)
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
          visit order_path(order)

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
          visit order_path(order)


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
          visit order_path(order)

          page.should have_content(order.returned_at)
        end
      end

    end
  end
end
