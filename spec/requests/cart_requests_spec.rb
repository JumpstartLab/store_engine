require 'spec_helper'

describe "Using the shopping cart" do 
  context "When I'm on a product page" do
    let(:product) { Fabricate(:product) }
    before(:each) { visit product_path(product) }

    context "And I click 'add to cart'" do
      before(:each) { click_link_or_button "Add to Cart" }

      context "And the cart was empty" do
        it "takes me to the cart page"do
          page.should have_selector("#cart")
        end
        it "shows me the product in my cart" do
          within("#cart") do
            page.should have_content(product.title)
          end
        end

        it "shows the quantity of the product in my cart" do
          within("#cart") do
            page.should have_selector("##{product.id}_quant")
          end
        end
        it "shows the total price of the product in my cart"
        it "shows the total price of all products in my cart"
      end

      context "And the cart was not empty" do
        it "takes me to the cart page"
        it "shows me the product in my cart"
        it "shows the quantity of the product in my cart"
        it "shows the total price of the product in my cart"
        it "shows the previous item(s) in my cart"
        it "shows the previous item(s) quantity(s) in my cart"
        it "shows the previous items(s) price in my cart" 
        it "shows the total price of all products in my cart"
      end
    end
  end
end