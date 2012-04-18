require 'spec_helper'

describe "Categories Admin Requests" do
  let(:category) { Fabricate(:category) }
  let(:user)     { Fabricate(:user,
                    :password => 'password',
                    :admin => true)}
  context "as an admin" do
    before(:each) do
      login(user)
    end

    it "shows a link to add a category" do
      visit "/categories"
      within("#add_link") do
        page.should have_link('Add a category',
                              href: new_category_path)
      end
    end

    it "creates a new category within the form" do
      visit "/categories"
      click_link_or_button "Add a category"

      within("#new_category") do
        fill_in 'category_name', :with => "#{category.name}"
      end
      click_button 'Create Category'
      current_path.should == "/categories"
      page.should have_content(category.name)
      page.should have_link(category.name, href: "/categories/#{category.id}")
    end

    it "edits an existing category via the from" do
      visit category_path(category)
      click_link("Edit")
      within(".edit_category") do
        fill_in 'category_name', :with => 'Pulpy Romance Novels'
      end
      click_button 'Update Category'
      current_path.should == category_path(category)
      page.should have_content("Pulpy Romance Novels")
    end

    it "deletes a category" do
      visit category_path(category)
      click_link("Delete")
      current_path.should == categories_path
      page.should_not have_content(category.name)
      Category.all.should_not include(category)
    end

  end
end