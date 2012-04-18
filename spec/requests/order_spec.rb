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
  end

  
  describe "GET /order/:id" do
    before(:each) do
      visit order_path(order)
    end

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
    before(:each) do
      visit orders_path
    end
    context "when user is not an admin" do

      it "shows id of order" do
        page.should have_content(order.id)
      end

      it "shows the ship-to name" do
        page.should have_content(order.name)
      end

      it "has the date ordered" do
        #page.should have_content("ago")
      end

      it "has the order status" do
        page.should have_content(order.status)
      end
    end
  end

  describe "GET /orders/new" do
    before(:each) do
      visit new_order_path
    end

    context "when cart is empty" do
      it "redirects to products path" do
        page.should have_content("All Products")
      end
    end

    context "when there's something in the cart" do
      let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
      let(:cart) do
        Cart.new()
        # cart.user = user
        # cart.save
      end 
      let!(:line_item) do
        li = LineItem.new(product: product)
        li.cart = cart
        li.quantity = 2
        li.save
        li
      end

      it "redirects to new order details" do
        # page.should have_content("Ship to name")
      end
    end
  end

  describe "POST /orders/one-click/:product_id" do
    context "when I'm logged in and have a previous order" do
      it "creates an order from a product" do
        # visit one_click_path(product.id)
        
      end
    end
  end


end
