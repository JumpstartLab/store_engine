require 'spec_helper'

describe Category do
  context "show" do
    let(:category) { Fabricate(:category) }
    let(:product)  { Fabricate(:product) }

    before(:all) do
      category.add_product(product)
    end

    it "lists all of the products for that category" do
      visit category_path(category)
      page.should have_content(product.title)
    end
  end  
end