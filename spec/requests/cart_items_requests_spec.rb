require 'spec_helper'

describe "Cart Items Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

  context "When creating a new cart item" do
    it "redirects to the shopping cart" do
      login_user_post("admin", "admin")
      visit "/products/1"
      find_button('Add to Cart').click
      current_path.should == shopping_cart_path
    end
  end
end
