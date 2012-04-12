require 'spec_helper'

describe "Categories Admin Requests" do
  let(:category) { Fabricate(:category) }
  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      login(@user)
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

  end
end