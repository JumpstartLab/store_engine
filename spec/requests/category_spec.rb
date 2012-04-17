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
      context "Modify Products" do
        it "validation passed" do
          visit edit_category_path(category)
          fill_in "category[name]", :with => "foooooo"
          click_on "Save Category"
          page.should have_content("Category upated.")
        end
        it "validation failed" do
          visit edit_category_path(category)
          fill_in "category[name]", :with => ""
          click_on "Save Category"
          page.should have_content("Update Failed.")
        end
      end
      context "Creating a product" do
        it "validation passed" do
          visit new_category_path
          fill_in "category[name]", :with => "Woo"
          click_on "Save Category"
          page.should have_content("Category created.")    
        end
        it "validation failed" do
          visit new_category_path
          fill_in "category[name]", :with => ""
          click_on "Save Category"
          page.should have_content "Create failed."
        end
      end
      context "DESTROY" do
        let(:category2) { FactoryGirl.create(:category) }
        it "Can destory" do
           visit categories_path
           save_and_open_page
           within("#category_#{category2.id}") do
            click_on "X"
           end
           page.should have_content "Category deleted."
        end
      end
      it "can view all categories" do
        visit categories_path
        page.should have_content "Dashboard - Categories"
      end
    end
  end
end