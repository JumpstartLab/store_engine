require 'spec_helper'

describe Product do
  let(:product) {FactoryGirl.build(:product, :id => 1)}
  let(:line_item) {FactoryGirl.build(:line_item, :product_id => product.id)}

  context "ensure not in line items" do
    it "should return false if a line item contains the product" do
      product.ensure_not_in_line_item.should == false
    end
  end
end
