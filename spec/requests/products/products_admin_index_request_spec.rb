require 'spec_helper'

describe "Products Admin Requests" do
  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      visit "/login"
      fill_in 'email', :with => @user.email
      fill_in 'password', :with => 'password'
      click_button 'Log in'
    end

    it "shows a link to add a product" do
      visit "/products"
      within("p#add_product") do
        page.should have_link('Add a product', href: new_product_path)
      end
    end

  end
end