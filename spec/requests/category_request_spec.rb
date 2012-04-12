require 'spec_helper'

describe Category do
  context "show" do
    let!(:category) { Fabricate(:category) }
    let!(:product)  { Fabricate(:product) }
    
    it "lists all of the products for that category" do
      category.add_product(product)
      visit category_path(category)
      page.should have_content(product.title)
    end
  end

  context "index" do
    it "lists all the categories"
  end
end