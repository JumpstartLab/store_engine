require 'spec_helper'

describe "Categories Requests" do
  let!(:category) { Fabricate(:category, :name => "Apples") }
  let!(:category2) { Fabricate(:category, :name => "Oranges") }

  context "When I visit the categories index page" do
    before(:each) do
      visit categories_path
    end

    it "shows Product Categories header" do
      page.should have_content("Product Categories")
    end

    it "shows all of the categories" do
      page.should have_content("Apples")
      page.should have_content("Oranges")
    end

    it "creates a list of the categories" do
      within ("li") do
        page.should have_content("Apples")
      end
    end   
  end

  context "When we edit a category" do
    before(:each) { visit edit_category_path(category) }
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
      visit new_category_path
      fill_in "Name", :with => "Bananas"
      click_button("Create Category")
      page.should have_content("Bananas")
    end
  end
end