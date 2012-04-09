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

      context "when I try to remove a product" do
        before(:each) { click_link_or_button("Remove from cart") }

        it "does not have any products in the cart" do
          within("#cart") do
            page.should_not have_content(product.name)
          end
        end
      end

      context "when I add multiple items to the cart" do
        before(:each) do
          visit product_path(product)
          click_link_or_button("Add to cart" )
        end

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

  context "when I'm on the cart page" do
    # context "when I try to update the quantity of a product" do
    #   it "does not have any products in the cart" do
    #     fill_in "user_name",         with: "Example User"
    #     within("#cart") do
    #       page.should_not have_content(product.name)
    #       click_link_or_button("update")
    #     end
    #   end
    # end
  end
end