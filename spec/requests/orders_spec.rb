require 'spec_helper'

describe Order do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc", upc: "072140002282") }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) { OrderItem.create(order: order, product: product, quantity: 1, price: 2) }
  

  context "when user is not an admin" do
    before(:each) do
      order.user = user
      order.save 
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "123"
      click_button "Log in"
      visit order_path(order)
    end

    describe "POST /order" do
      it "prohibits you from checkout if no items in cart" do
        visit products_path
        click_on "View Cart"
        click_on "Checkout"
        page.should have_content("Cart is empty")
      end

      # it "enables you to checkout if cart has contents" do
      #   visit products_path
      #   click_on "Add to Cart"
      #   click_on "Checkout"
      #   fill_in "order_name", with: "Testing1234"
      #   fill_in "order_address", with: "1234 fake st"
      #   fill_in "order_email", with: "testemail@fake.com"
      #   page.select("Check", :from => "order_pay_type")
      #   click_button "Place Order"
      #   page.should have_content("Thank you for your order")
      # end

      it "enables one-click checkout if there is a previous order" do
        visit products_path
        click_on "Add to Cart"
        click_on "Checkout"
        fill_in "order_name", with: "Testing1234"
        fill_in "order_address", with: "1234 fake st"
        fill_in "order_email", with: "testemail@fake.com"
        fill_in "order_email", with: "testemail@fake.com"
        fill_in "order_cc_number", with: "1234567890"
        fill_in "order_cc_expiry", with: "12/12"
        click_button "Place Order"
        visit product_path(product)
        click_on "One-Click Checkout"
      end
    end

    describe "GET /order/:id" do
      it "includes shipping name" do
        page.should have_content(order.name)
      end

      it "includes order total" do
        page.should have_content(order.total)
      end

      it "includes shipping address" do
        page.should have_content(order.address)
      end

      it "includes shipping email" do
        page.should have_content(order.email)
      end

      it "includes order date" do
        page.should have_content("ago")
      end

      it "includes status" do
        page.should have_content(order.status)
      end

      it "includes the product" do
        page.should have_content(order_item.product.title)
      end

      it "includes the quantity ordered" do
        page.should have_content(order_item.quantity)
      end

      it "includes the price of the product" do
        page.should have_content(order_item.price)
      end

      it "includes the subtotal of product ordered" do
        page.should have_content(order_item.subtotal)
      end
    end

    describe "GET /orders" do
      it "shows all orders made by the user" do
        visit orders_path
        user.orders.each do |order|
          page.should have_content(order.name)
        end
      end

      it "shows id of order" do
        page.should have_content(order.id)
      end

      it "shows the ship-to name" do
        page.should have_content(order.name)
      end

      it "has the order status" do
        page.should have_content(order.status)
      end
    end
  end

  context "when user is an admin" do
    before(:each) do
      visit login_path
      fill_in "email", with: admin_user.email
      fill_in "password", with: "123"
      click_button "Log in"
    end

    describe "GET /orders" do
      it "allows an admin to view all orders" do
        visit admin_report_orders_path
        Order.all.each do |order|
          page.should have_content(order.name)
        end
      end

      it "allows an admin to view orders by status" do
        visit admin_report_orders_path
        click_on "Pending"
        Order.all.each do |order|
          if order.status == "pending"
            page.should have_content(order.name)
          end
        end
      end

      it "admin can set order status to cancelled" do
        visit order_path(order)
        page.select("cancelled", :from => "order_status")
        click_button "update order status"
        page.should have_content("cancelled")
      end

      it "admin can set order status to paid" do
        visit order_path(order)
        page.select("paid", :from => "order_status")
        click_button "update order status"
        page.should have_content("paid")
      end

      it "admin can set order status to shipped" do
        visit order_path(order)
        page.select("shipped", :from => "order_status")
        click_button "update order status"
        page.should have_content("shipped")
      end
    end
  end
end
