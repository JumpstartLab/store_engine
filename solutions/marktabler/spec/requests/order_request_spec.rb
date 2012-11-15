require 'spec_helper'

 describe 'Order' do
    it "allows a signed-in user to place an order" do
      u = Fabricate(:user)
      p = Fabricate(:product)
      log_in(u, 'asdfasdf')
      visit product_path(p)
      click_button "Add Item To Cart"
      click_link "Checkout"
      click_button "Place Order"
      page.should have_content "Order placed!"
    end
  end