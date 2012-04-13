require 'spec_helper'

describe "Categories Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:category) { Fabricate(:category, :name => "Apples") }
  let!(:category2) { Fabricate(:category, :name => "Oranges") }
  
  context "When we edit a category" do
    before(:each) do
      login_user_post("admin", "admin")
      visit edit_admin_category_path(category) 
    end 

    it "shows title" do
      page.should have_content("Edit Category")
    end

    it "updates category" do
      fill_in 'Name', :with => "Grapes"
      click_button "Update Category"
      page.should have_content "Grapes"
    end
  end

  context "When I add a category" do
    it "shows the new category" do
      login_user_post("admin", "admin")
      visit new_admin_category_path
      fill_in "Name", :with => "Bananas"
      click_button("Create Category")
      page.should have_content("Bananas")
    end
  end
end
