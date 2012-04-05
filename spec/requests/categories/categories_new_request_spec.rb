require 'spec_helper'

describe "Create New Category" do
  context "when creating new product" do
    before(:each) do
      visit "/categories/new"
    end

    it "creates a new category via the from" do
      within(".new_category") do
        fill_in 'category_name', :with => 'Pulpy Romance Novels'
      end
      click_button 'Create Category'
      current_path.should == "/categories"
      page.should have_link("Pulpy Romance Novels")
    end

  end
  
end