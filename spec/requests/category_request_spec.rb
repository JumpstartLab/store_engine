require 'spec_helper'

describe Category do
  let!(:category) { Fabricate(:category) }
  let!(:product)  { Fabricate(:product) }

  context "show" do
    it "lists all of the products for that category" do
      category.add_product(product)
      visit category_path(category)
      page.should have_content(product.title)
    end
  end

  context "index" do
    it "lists all the categories" do
      visit root_path
      click_link "Browse by Category"
      page.should have_content("#{category.name}")
    end
  end
end