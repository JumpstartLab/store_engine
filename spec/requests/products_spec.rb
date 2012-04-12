require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get products_path
      response.status.should be(200)
    end
  end

  context "when I'm on the products page" do
    before(:each) { visit products_path }
      context "and I click add to cart on a product" do
        # before(:each) { click_link_or_button('Add to cart') }
        # it "should add the item to the cart" do
          
        # end
      end
  end
end
