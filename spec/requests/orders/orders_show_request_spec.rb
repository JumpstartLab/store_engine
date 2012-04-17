require 'spec_helper'

describe "Orders" do
  let(:product)     { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}
  let(:user)        { Fabricate(:user) }

  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let!(:order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }
  let!(:order_product)   { OrderProduct.create(:product_id => product.id,
                                              :order_id => order.id,
                                              :quantity => 3)}

  context "when not logged in" do
    it "prevents you from viewing an order" do
      visit logout_path
      visit order_path(order)

      page.should have_content("You don't have access to this page.")
    end
  end


  context "when logged in as a user" do

    context "and viewing an order" do
      before(:each) do
        visit order_path(order)
      end

      it "shows the time the order was placed" do
        page.should have_content(order.placed_at)
      end


      context "and the order is pending" do
        it "shows the time the order was marked pending" do
          visit order_path(order)
          within "#order_product_#{order.order_products.last.id}" do
            page.should have_selector(".edit_order_product")
          end
        end
      end

      context "and the order is paid" do
        it "shows the time the order was marked paid" do
          order.order_status << OrderStatus.create(:status => "paid")
          page.should have_content("Paid at")
        end
      end

      context "and the order is shipped" do
        it "shows the time the order was marked shipped" do
          order.order_status << OrderStatus.create(:status => "shipped")
          page.should have_content("Shipped at")
        end
      end

      context "and the order is cancelled" do
        it "shows the time the order was marked cancelled" do
          order.order_status << OrderStatus.create(:status => "cancelled")
          page.should have_content("Cancelled at")
        end
      end

      context "and the order is returned" do
        it "shows the time the order was marked returned" do
          order.order_status << OrderStatus.create(:status => "returned")
          page.should have_content("Returned at")
        end
      end

    end
  end
end