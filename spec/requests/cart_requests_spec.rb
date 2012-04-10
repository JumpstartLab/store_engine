require 'spec_helper'

describe Cart do
  let(:product) { Fabricate(:product) }
  let(:cart) { Fabricate(:cart) }
  let(:category) { Fabricate(:category) }

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

  context "is linked from" do
    it "the products page" do
      visit products_path
      page.should have_content("View Cart")
    end

    it "a product page" do
      visit product_path(product)
      page.should have_content("View Cart")
    end

    it "a category page" do
      visit category_path(category)
      page.should have_content("View Cart")
    end
  end

  context "can be visited by clicking 'View Cart' from" do
    it "the products page" do
      visit products_path
      click_link "View Cart"
      page.should have_content("Your Cart")
    end

    it "a product page" do
      visit product_path(product)
      click_link "View Cart"
      page.should have_content("Your Cart")
    end

    it "a category page" do
      visit category_path(category)
      click_link "View Cart"
      page.should have_content("Your Cart")
    end
  end
end