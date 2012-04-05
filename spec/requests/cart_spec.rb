require 'spec_helper'

describe 'using the shopping cart' do
  context "When I'm on a product page" do
    let(:product) { Fabricate(:product) }
    before(:each) { visit product_path(product) }

    context "and I click add to cart" do
      before(:each) { click_link_or_button "Add to Cart" }

      it "takes me to the cart page" do
        page.should have_content("Your Cart")
      end

      it "shows the product in my cart" do
        within("#cart") do
          page.should have_content(product.title)
        end
      end
    end
  end
end
