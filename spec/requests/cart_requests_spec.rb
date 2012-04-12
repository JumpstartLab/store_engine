require 'spec_helper'

describe "Using the shopping cart" do 
  context "When I'm on a product page" do
    let(:product) { Fabricate(:product, :price => 10) }

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
        it "shows the total price of the product in my cart" do
          within("#cart") do
            page.should have_content(product.price)
          end
        end
      end

      context "when I add multiple items to the cart" do
        let(:second_product) { Fabricate(:product, :price => 15) }

        before(:each) do
          visit product_path(product)
          click_link_or_button "Add to Cart"

          visit product_path(second_product)
          click_link_or_button "Add to Cart"
        end

        it "takes me to the cart page" do
          page.should have_selector("#cart")
        end        

        it "shows each item in the cart" do
          within("#cart") do
            page.should have_content(product.title)
            page.should have_content(second_product.title)
          end
        end

        it "shows the quantity of the products in my cart" do
          visit product_path(product)
          click_link_or_button "Add to Cart"

          within("#cart") do
            within ("##{product.id}_quant") do
              page.should have_content(3)
              # Content is 3 b/c this is added twice - once @ top context & once halfway down
            end
          end
        end
        
        it "shows the total price of the specific product in my cart" do
          within ("#cart") do
            within ("##{product.id}_total") do
              page.should have_content(product.price * 2)
            end
          end
        end

        it "shows the total price of all products in my cart" do
          product.price = 10
          second_product.price = 15


          within ("#total") do
            page.should have_content((product.price * 2) + (second_product.price) )
          end
        end
      end
    end

    context "and the place order button is clicked" do
      # before(:each) { click_link_or_button("Place Order") }

      it "creates an order" do
        pending "This should be moved to an order spec"
        current_orders = Order.count
        click_link_or_button("Place Order")
        current_orders.should == current_orders + 1
      end

    end
  end
end