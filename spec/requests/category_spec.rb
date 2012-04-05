require 'spec_helper'

describe "Test Category Auth" do    
  context "Logged Out" do
    it "can't edit products" do
      c = FactoryGirl.create(:category)
      visit edit_category_path(c)
      page.should have_content("Must be an administrator")
    end
    it "can't create a new product" do
      visit new_category_path
      page.should have_content("Must be an administrator")
    end
    it "Browse by category" do
      c = FactoryGirl.create(:category)
      visit category_path(c)
      page.should have_content(c.name)
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
        c = FactoryGirl.create(:category)
        visit edit_category_path(c)
        page.should have_content("Must be an administrator")
      end
      it "can't create a new product" do
        visit new_category_path
        page.should have_content("Must be an administrator")
      end
    end
    context "Admin" do
      let!(:user) do
        FactoryGirl.create(:admin, :password => "mike")
      end
      it "can edit products" do
        c = FactoryGirl.create(:category)
        visit edit_category_path(c)
        page.should have_content("Edit Category")
      end
      it "can create a new product" do
        visit new_category_path
        page.should have_content("New Category")        
      end
    end
  end
end