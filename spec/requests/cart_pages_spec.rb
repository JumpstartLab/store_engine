require 'spec_helper'

describe "Using the shopping cart" do
  context "when I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit product_path(product) }

    context "and I click 'add to cart'" do
      before(:each) { click_link("Add to cart") }

      it "takes me to the cart page" do
        page.should have_content("Your Cart")
      end

      it "shows the product in my cart" do
        # save_and_open_page
        within("#cart") do
          page.should have_content(product.name)
        end
      end

      it "shows a product quantity" do
        within("#cart") do
          page.should have_selector("input#cart_product_quantity", :value => 1)
        end
      end

      it "shows the subtotal" do
        within("#cart") do
          page.should have_content(product.price.to_s)
        end
      end

      context "when I go back" do
        before(:each) { visit product_path(product) }
        
        context "and I click 'add to cart' again" do
          before(:each) { click_link_or_button("Add to cart" ) }

          it "shows an increased product quantity" do
            within("#cart") do
              page.should have_selector("input#cart_product_quantity", :value => 2)
            end
          end

          it "shows the original price" do
            within("#cart") do
              page.should have_content("")
            end
          end
        end
      end

    end

  end
end