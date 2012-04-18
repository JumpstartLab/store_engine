require 'spec_helper'
  describe 'Admin Category' do
    it "allows an admin to view a category" do
      u = Fabricate(:user)
      c = Fabricate(:category)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit admin_category_path(c)
      page.should have_content c.name
    end

    it "allows an admin to edit a category" do
      u = Fabricate(:user)
      c = Fabricate(:category)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit edit_admin_category_path(c)
      fill_in "Name", with: "Adjusted Name"
      click_button "Update Category"
      visit admin_category_path(c)
      page.should have_content "Adjusted Name"
    end

    it "allows an admin to delete a category" do
      u = Fabricate(:user)
      c = Fabricate(:category)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit admin_category_path(c)
      click_link "Delete"
      visit admin_categories_path(c)
      page.should_not have_content c.name
    end

  end