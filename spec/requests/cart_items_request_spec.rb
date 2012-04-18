require 'spec_helper'
  describe 'Cart' do
    it "allows a user to add an item to their cart" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      log_in(u, 'asdfasdf')
      visit product_path(p)
      click_button "Add Item To Cart"
      within "#mini_cart" do
        page.should have_content p.name
      end
    end

    it "allows a user to increase the quantity of a cart item" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      log_in(u, 'asdfasdf')
      visit product_path(p)
      click_button "Add Item To Cart"
      click_link "+"
      within "#mini_cart" do
        page.should have_content "2"
      end
    end


    it "allows a user to decrease the quantity of a cart item" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      log_in(u, 'asdfasdf')
      visit product_path(p)
      click_button "Add Item To Cart"
      Cart.last.cart_items.last.update_attribute(:quantity, 4)
      click_link "-"
      within "#mini_cart" do
        page.should have_content "3"
      end
    end

    it "allows a user to delete a cart item" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      log_in(u, 'asdfasdf')
      visit product_path(p)
      click_button "Add Item To Cart"
      click_link "x"
      within "#mini_cart" do
        page.should_not have_content p.name
      end
    end

  end