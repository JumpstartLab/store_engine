require 'spec_helper'

describe "Product" do    
  context "Logged Out" do
    it "can't edit products" do
      p = FactoryGirl.create(:product)
      visit edit_product_path(p)
      page.should have_content("Must be an administrator")
    end
    it "can't create a new product" do
      visit new_product_path
      page.should have_content("Must be an administrator")
    end
    context "Browsing" do
      it "Browse all products" do
        visit '/products'
        page.should have_content("Products")
      end
    end
  end
  context "Auth" do

    before(:each) do
     visit '/login'
     fill_in 'user[email]', :with => user.email
     fill_in 'user[password]', :with => "mike"
     click_button("Sign In")
    end

    context "User" do
      let!(:user) do
        FactoryGirl.create(:user, :password => "mike")
      end
      it "can't edit products" do
        p = FactoryGirl.create(:product)
        visit edit_product_path(p)
        page.should have_content("Must be an administrator")
      end
      it "can't create a new product" do
        visit new_product_path
        page.should have_content("Must be an administrator")
      end
    end
    context "Admin" do
      let!(:user) do
        FactoryGirl.create(:admin, :password => "mike")
      end
      it "can edit products" do
        p = FactoryGirl.create(:product)
        visit edit_product_path(p)
        page.should have_content("Edit Product")
      end
      it "can create a new product" do
        visit new_product_path
        page.should have_content("New Product")        
      end
    end
  end
end