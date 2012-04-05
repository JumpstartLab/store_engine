require 'spec_helper'

describe "User Requests" do
  context "root" do
    let!(:users) { [Fabricate(:user), Fabricate(:user)] }

    # before(:each) { visit categories_path }

    # it "links to the category" do
    #   within("table.table-striped") do
    #     categories.each do |category|
    #       page.should have_selector("td##{dom_id(category)}")
    #       page.should have_link(category.name, href: category_path(category))
    #     end
    #   end
    # end
    # context "new" do
    #   before(:each) { visit new_category_path }
    #   it "has a form with all of the correct fields" do
    #     within ("form#new_category") do
    #       page.should have_selector("input#category_name")
    #     end
    #   end
    # end
    # context "create" do
    #   before(:each) do
    #     @count = Category.all.count
    #     visit new_category_path
    #     fill_in "category_name", with: "Test"
    #     click_button 'Create Category'
    #   end
    #   it "creates a category" do
    #     Category.all.count.should == @count + 1
    #   end
    #   it "redirects to the category" do
    #     current_path.should == category_path(Category.all.last)
    #   end
    # end
    # context "delete" do
    #   before(:each) do
    #     visit new_category_path
    #     fill_in "category_name", with: "Test"
    #     click_button 'Create Category'
    #     @count = Category.all.count
    #     visit categories_path
    #     within "tr#category_1" do
    #       click_link 'Destroy'
    #     end
    #   end
    #   it "deletes a category" do
    #     Category.all.count.should == @count - 1
    #   end
    #   it "redirects to the index" do
    #     current_path.should == categories_path
    #   end
    # end
    # context "update" do
    #   before(:each) do
    #     visit new_category_path
    #     fill_in "category_name", with: "Test"
    #     click_button 'Create Category'
    #     visit edit_category_path(Category.all.last)
    #     fill_in "category_name", with: "Updated"
    #     click_button 'Update Category'
    #   end
    #   it "updates a category" do
    #     Category.last.name.should == "Updated"
    #   end
    #   it "redirects to the category" do
    #     current_path.should == category_path(Category.all.last)
    #   end
    # end
  end
end