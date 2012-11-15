require 'spec_helper'

describe "Users Sessions requests" do
  let!(:user) { Fabricate(:user)}
  context "when a normal user is logged in" do

    it "redirects to root" do
      login 
      visit '/login'
      page.current_path.should == root_path
    end
  end

  context "when a user is not logged in" do
    let!(:product) { Fabricate(:product) }
    let!(:product2) { Fabricate(:product) }

    context "when a user logs in with items in the cart" do
      it "adds the cart items" do
        visit product_path(product)
        click_button "Add to Cart"
        login
        visit shopping_cart_path
        page.should have_content(product.title)
        cart_item_id = user.shopping_cart.cart_items.first.id
        find_field("quantity_#{cart_item_id}").value.should == "1"
      end

      context "when the logged in user has the same item in the cart" do
        it "merges the cart items" do
          login
          visit product_path(product)
          click_button "Add to Cart"
          visit logout_path

          visit product_path(product)
          click_button "Add to Cart"
          login
          visit shopping_cart_path
          page.should have_content(product.title)
          cart_item_id = user.shopping_cart.cart_items.first.id
          find_field("quantity_#{cart_item_id}").value.should == "2"
        end
      end
    end
  end
end
