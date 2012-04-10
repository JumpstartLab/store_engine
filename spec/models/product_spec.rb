require 'spec_helper'

describe Product do
  let(:test_product) { Fabricate(:product) }

  describe ".active" do
    let(:inactive_product) { Product.create(:retired => true, :title =>"Test Title", :description => "Test Description") }

    it "does not return an inactive product" do
      Product.active.should_not include(inactive_product)
    end

    it "includes an active product" do
      Product.active.should include(test_product)
    end
  end

  describe "#categories" do
    context "when a product has been added to this category" do
      let(:category) { Fabricate(:category) }
      before(:each)  { category.add_product_by_id(test_product.id) }

      it "lists the categories associated with a product" do
        # raise test_product.inspect
        test_product.categories.should include(category)
      end
    end
  end
end
