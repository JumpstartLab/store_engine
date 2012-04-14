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

  describe "#category_list" do
    let(:category) {FactoryGirl.build(:category)}
    let(:category_assignment) {FactoryGirl.build(:category_assignment)}
    it "displays the categories for each product" do
      puts category_assignment.category.inspect
      product.category_list.should include("toys")
    end
  end
end
