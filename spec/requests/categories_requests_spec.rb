require 'spec_helper'

describe "Categories Requests" do
  context "index" do

    let!(:categories) { [Fabricate(:category), Fabricate(:category)] }

    before(:each) do
      visit "/categories/"
    end

    it "lists the categories" do
      within("ul#categories") do
        categories.each do |category|
          page.should have_selector("li#category_#{category.id}")
        end
      end
    end

    it "links to the categories" do
      within("ul#categories") do
        categories.each do |category|
          page.should have_link(category.name, :href => category_path(category))
        end
      end
    end

    it "displays the category when clickin the link" do
      category = categories.first
      within("li##{dom_id(category)}") do
        click_link(category.name)
      end
      current_path.should == category_path(category)
    end
  end

  context "show" do
    let!(:category) { Fabricate(:category) }

    before(:each) do
      visit category_path(category)
    end

    it "displays the name of the category" do
      page.should have_content(category.name)
    end

    it "has a link to the all categories page" do
      page.should have_selector("a[href$='#{categories_path}']")
    end

    it "displays the all products page when clicking the link" do
      click_link("back to all categories")
      current_path.should == categories_path
    end

  end
end