require 'spec_helper'

describe Category do
  let(:product) { Fabricate(:product) }
  let(:category) { Fabricate(:category) }

  context "#add_product" do
    it "adds a product to the category" do
      category.add_product(product)
      category.products.should include product
    end
  end
end
