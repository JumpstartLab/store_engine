require 'spec_helper'

describe "Cart Items Requests" do
  let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

  # Create new cart items
  context "When creating a new cart item" do
    it "redirects to the shopping cart" do
      visit "/products/1"
      find_button('Add to Cart').click

      current_path.should == shopping_cart_path
    end

    it "is added to the shopping cart" #do
    #   visit '/shopping_cart'
    # end
  end
  # redirect to the cart controller's index
end