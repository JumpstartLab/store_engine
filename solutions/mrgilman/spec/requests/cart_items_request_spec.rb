require 'spec_helper'

describe "Cart Items Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product, :title => "iPod") }

  before(:each) do
    login_user_post("admin", "admin")
  end

  context "when I add an item to the cart" do
    it "shows the newly created item in the cart" do
      params = { :product => product.id, :cart_item => {:quantity => 10} }
      page.driver.post(cart_items_path(product), params) 
      visit shopping_cart_path
      find_link(product.title).visible?
    end
  end
end
