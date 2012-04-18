require 'spec_helper'

describe Cart do

  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:product_2) { Product.create(title: "title2", price: 2, description: "desc2", retired: true) }

  describe "carts" do

    before(:each) do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "123"
      click_button "Log in"
    end

    describe "Carts" do
      it "can add an item to a cart" do
        visit products_path
        click_on "Add to Cart"
        page.should have_content(product.title)
      end

      it "can update the quantity an item in cart" do
        visit products_path
        click_on "Add to Cart"
        fill_in "line_item_quantity", with: 3
        click_button "update quantity"
        page.should have_content("Cart Total: $6.00")
      end

      it "can remove an item from a cart" do
        visit products_path
        click_on "Add to Cart"
        click_on "Remove From Cart"
        page.should have_content("Your cart currently has no items.")
      end
    end
  end
end
