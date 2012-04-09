require 'spec_helper'

describe LineItem do
  let(:item) { Fabricate(:line_item) }
  describe "#subtotal" do
    it "returns the subtotal of the line item" do
      float_sub_total = item.quantity.to_f * item.price.to_f
      item.subtotal.should == BigDecimal.new(float_sub_total,2)
    end
  end
end
