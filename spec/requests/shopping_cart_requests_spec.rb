require 'spec_helper'

describe "Shopping Cart Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product, :title => "iPod") }
  let!(:product2) { Fabricate(:product, :title => "Macbook Pro") }

  before(:each) do
    login_user_post("admin", "admin")
  end

  
  context "when I visit the shopping cart" do
    it "should show the logged in users' cart items " do
      user.shopping_cart = Fabricate(:shopping_cart)
      user.shopping_cart.add_item(product.id, 10)
      visit shopping_cart_path
      find_link(product.title).visible? 
    end

    it "should allow me to remove an item from my cart" do
      user.shopping_cart = Fabricate(:shopping_cart)
      user.shopping_cart.add_item(product.id, 10)
      user.shopping_cart.add_item(product2.id, 20)
      visit shopping_cart_path
      click_link("Remove")
      page.should_not have_content(product.title)
      page.should have_content(product2.title)
    end
  end

  context "when I add an item to the cart" do
    it "should show the newly created item in the cart" do
      params = { :product => product.id, :cart_item => {:quantity => 10} }
      page.driver.put(shopping_cart_path(product), params) 
      visit shopping_cart_path
      find_link(product.title).visible?
    end
  end

end