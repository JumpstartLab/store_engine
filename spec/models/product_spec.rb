require 'spec_helper'

describe Product do
  let!(:product) {FactoryGirl.build(:product, :id => 1)}
  let!(:line_item) do
    li = LineItem.new(product: product)
    li.quantity = 2
    li.save
    li
  end

  context "#ensure_not_in_line_items" do
    it "should return false if a line item contains the product" do
      product.ensure_not_in_line_item.should == false
    end
  end
end
