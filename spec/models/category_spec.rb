require 'spec_helper'

describe Category do
  let!(:category) { Category.create() }
  
  describe "#ensure_not_assigned" do

    it "returns false if the category has no products" do
      category.ensure_not_assigned.should == true
    end

    context "when there are products assigned" do
      let!(:product) { Product.create(title: "Sample", description: "Sample", price: 2) }
      let!(:category_assignment) { CategoryAssignment.create(category: category, product: product) }

      it "returns true" do
        category.ensure_not_assigned.should == false
      end
    end
  end
end
