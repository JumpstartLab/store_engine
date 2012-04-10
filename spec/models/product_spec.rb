require 'spec_helper'

describe Product do

  describe "#set_categories" do
    context "When adding categories to a product" do

      let!(:product) { Fabricate(:product) }
      let!(:category) { Fabricate(:category) }
      let!(:category2) { Fabricate(:category) }

      it "sets a category" do
        product.categories.length.should == 0
        product.set_categories([category.id])
        product.categories.length.should == 1
        product.categories.include?(category).should == true
      end

      it "sets unique categories" do
        product.set_categories([category.id, category.id])
        product.categories.length.should == 1
      end

      it "sets multiple categories" do
        product.set_categories([category.id, category2.id])
        product.categories.length.should == 2
        product.categories.include?(category).should == true
        product.categories.include?(category2).should == true
      end
    end
  end
end
