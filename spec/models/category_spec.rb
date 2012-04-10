require 'spec_helper'

describe Category do
  let(:category) { Fabricate(:category) }
  let(:product) { Fabricate(:product) }
  let(:products) { [product, Fabricate(:product)] }

  describe "#add_product_by_id" do
    it "adds a product to the category" do
      expect {
        category.add_product_by_id(product.id)
      }.to change { category.products.count }.by(1)
    end
  end
end
