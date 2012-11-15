require 'spec_helper'

describe OrderItem do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:product_2) { Product.create(title: "title2", price: 4, description: "new desc") }
  let!(:order) { FactoryGirl.create(:order, user: user) }
  let!(:order_item) { OrderItem.create(order: order, product: product, quantity: 1, price: 2) }
  let!(:order_item_2) { OrderItem.create(order: order, product: product_2, quantity: 2, price: 4) }


  context "logged in as an admin" do
    before(:each) do
      visit login_path
      fill_in "email", with: admin_user.email
      fill_in "password", with: "123"
      click_button "Log in"
    end

    #this should probably be moved to order spec
    describe "GET /orders" do
      it "the order shows 2 order items" do
        visit order_path(order)
        order.order_items.length.should == 2
      end

      it "shows the title of each order item" do
        visit order_path(order)
        order.order_items.each do |order_item|
          page.should have_content(order_item.product.title)
        end
      end

      it "enables an admin to delete an order item" do
        visit order_path(order)
        page.should have_content("title2")
        within ("#order_item_#{order_item_2.id}") do
          click_on "Remove Product from Order"
        end
        page.should_not have_content("title2")
      end

      it "enables an admin to change an order item quanity" do
        visit order_path(order)
        within ("#edit_order_item_#{order_item.id}") do
          fill_in "order_item_quantity", with: 3
          click_button "update quantity"
        end
        page.should have_content("Quantity: 3")
      end
    end
  end
end

