require 'spec_helper'
 include ActionView::Helpers::NumberHelper

describe 'using the shopping cart' do
  context "When I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit product_path(product) }

    context "and I click add to cart" do
      before(:each) { click_link_or_button "Add to Cart" }

      it "takes me to the cart page" do
        page.should have_css('h1', :text => 'Cart')
      end

      it "shows the product in my cart" do
        within("#cart") do
          page.should have_content(product.title)
        end
      end
      
      context "when I already have that item in a cart" do
        before(:each) { visit product_path(product) }
        before(:each) { click_link_or_button "Add to Cart" }

        it "increases the quantity for an existing item" do
          page.should have_content("2 items")
        end

        it "should list only one copy of the item" do
          page.should_not have_selector('a', :href => product_path(product), :count => 2)
        end
      end 
    end
  end

  context "when I'm on the cart" do
    let(:products) do
      (1..5).map { FactoryGirl.create(:product) }
    end
    let(:test_cart) { FactoryGirl.create(:cart, :products => products)}

    before(:each) { load_cart_with_products(products) }

    it "removes the item when I click remove" do
      within("#product_#{products.first.id}") do
        click_link_or_button "Remove item"
      end
      page.should_not have_content(products.first.title)
    end

    it "shows the total price of the items" do
      page.should have_content(number_to_currency(test_cart.total_price))
    end

    it "shows the total price for each item" do
      product = FactoryGirl.create(:product) 
      n = rand(2..100)
      n.times { load_cart_with_products([product]) }
      page.should have_content(number_to_currency(product.price * n))
    end

    it "lets me update quantity of the items" do
      within("#product_#{products.first.id}") do
        click_link_or_button "Edit Quantity"
      end
      fill_in "cart_item_quantity", :with => "96"
      click_on "Update Cart item"
      page.should have_content("96")
    end
  end
end
