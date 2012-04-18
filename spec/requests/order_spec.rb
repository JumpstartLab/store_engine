require 'spec_helper'

describe Order do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) { OrderItem.create(order: order, product: product, quantity: 1, price: 2) }

  before(:each) do
    order.user = user
    order.save 
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: "123"
    click_button "Log in"
    visit order_path(order)
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

    it "includes pay type" do
      page.should have_content(order.pay_type)
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
    context "when user is not an admin" do

      it "shows id of order" do
        page.should have_content(order.id)
      end

      it "shows the ship-to name" do
        page.should have_content(order.name)
      end

      it "has the date ordered" do
        pending page.should have_content("ago")
      end

      it "has the order status" do
        page.should have_content(order.status)
      end
    end
  end
end
