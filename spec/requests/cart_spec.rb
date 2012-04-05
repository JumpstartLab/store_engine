require 'spec_helper'

describe "Using the shopping cart", :focus => true do
  context "when I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) do 
      visit product_path(product)
    end

    context "and I click 'add to cart'" do
      before(:each) do 
        click_button("Add to cart")
      end

      it "takes me to the cart page" do
        page.should have_content("Your Cart")
      end

      it "shows the product in my cart" do
        # save_and_open_page
        within("#cart") do
          page.should have_content(product.name)
        end
      end

      it "shows the total cart quantity" do
        within("#cart") do
          page.should have_content("Total items: 1")
        end
      end

      it "shows the cart total" do
        within("#cart") do
          page.should have_content("Total cost: " + product.price.to_s)
        end
      end
    end

  end
end