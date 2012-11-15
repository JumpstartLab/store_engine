require 'spec_helper'

describe "Categories Requests" do
  let!(:category) { Fabricate(:category, :name => "Apples") }
  let!(:category2) { Fabricate(:category, :name => "Oranges") }

  context "when logged in as admin " do
    let!(:user) { Fabricate(:user, :admin => true) }
    before(:each) { login }

    context "When we edit a category" do
      before(:each) do
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
        visit new_admin_category_path
        fill_in "Name", :with => "Bananas"
        click_button("Create Category")
        page.should have_content("Bananas")
      end
    end
  end

  context "when not an admin" do
    it "shows categories page not found" do
      validate_not_found(admin_categories_path)
    end

    it "shows new category page not found" do
      validate_not_found(new_admin_category_path)
    end

    it "shows create category page not found" do
      validate_not_found(admin_categories_path(category), "post")
    end

    it "shows category edit page not found" do
      validate_not_found(edit_admin_category_path(category))
    end

    it "shows category update page not found" do
      validate_not_found(admin_category_path(category), "put")
    end
  end
end
