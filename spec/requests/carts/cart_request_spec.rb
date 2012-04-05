require 'spec_helper'

describe "Using the shopping cart" do
  let(:cart)      { Cart.create }
  let(:product)   { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}


  context "when adding products to the cart" do

    context "and I'm on a product page" do
      before(:each) do
        visit product_path(product)
      end

      context "and I click 'add to cart'" do
        before(:each) do
          click_link_or_button "add to cart"
        end
    
        it "takes me to my cart" do
          # save_and_open_page
          page.should have_content("Your Cart")
        end

        it "shows the product in my cart" do
          within("#cart") do
            page.should have_content(product.title)
          end
        end

        it "links back to product index" do
          page.should have_link("", :href => products_path)
        end
      end
    end

    it "persists the cart for adding multiple items" do
      visit product_path(product)
      click_link_or_button "add to cart"
      visit product_path(new_product)
      click_link_or_button "add to cart"
      within "#cart" do
        products.each do |product|
          page.should have_content(product.title)
        end
      end
    end
  end

  context "when removing products from the cart" do
    context "when the cart contains a product" do
      before(:each) do
        visit product_path(product)
        click_link_or_button "add to cart"
      end

      it "shows a link to remove the product" do
        within("#cart") do
          page.should have_link("remove")
        end
      end

      it "returns me to the cart after removing" do
        within "#product_#{product.id}" do
          click_link_or_button "remove"
        end
        page.should have_content("Your Cart")
      end

      it "removes the product from the cart" do
        click_link_or_button "remove"
        within "#cart" do
          #save_and_open_page
          page.should_not include(product.title)
        end
      end
    end
  end
end