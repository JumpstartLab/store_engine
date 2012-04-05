require 'spec_helper'

describe "Test Category Auth" do   
  let(:category) do
    FactoryGirl.create(:category) 
  end
  context "Logged Out" do
    it "can't edit products" do
      visit edit_category_path(category)
      page.should have_content("Must be an administrator")
    end
    it "can't create a new product" do
      visit new_category_path
      page.should have_content("Must be an administrator")
    end
    it "Browse by category" do
      visit category_path(category)
      page.should have_content(category.name)
    end
  end
  context "Auth" do
    before(:each) do
      login(user)
    end
    context "User" do
      let!(:user) do
        FactoryGirl.create(:user, :password => "mike")
      end
      it "can't edit products" do
        visit edit_category_path(category)
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
        visit edit_category_path(category)
        page.should have_content("Edit Category")
      end
      it "can create a new product" do
        visit new_category_path
        page.should have_content("New Category")        
      end
    end
  end
end