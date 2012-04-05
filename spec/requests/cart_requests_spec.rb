require 'spec_helper'

describe Cart do
  let(:product) { Fabricate(:product) }
  let(:cart) { Fabricate(:cart) }

  context "when a user clicks on 'add to cart'" do
    before(:each) do
      visit product_path(product)
      click_link "Add to Cart"
    end
    it "adds the product to the cart" do
      visit cart_path
      within ("#cart") do
        page.should have_content(product.title)
      end
    end
  end 
end