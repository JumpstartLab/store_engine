require 'spec_helper'

describe "Category Requests" do
  context "index" do
    let!(:categories) do
      [category_one = Fabricate(:category),
       category_two = Fabricate(:category),
       category_three = Fabricate(:category)
      ]
    end
  
    before(:each) do
      visit "/categories"
    end

    it "lists the categories" do
      within("#categories") do
        categories.each do |category|
          page.should have_link(category.name, :href => category_path(category))
        end
      end
    end

    it "lists the categories" do
      within("#categories") do
        categories.each do |category|
          page.should have_selector(".category")
          page.should have_selector(
            "#category_#{category.id}"
            )
        end
      end
    end

  end
  
end