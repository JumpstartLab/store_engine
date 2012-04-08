require 'spec_helper'

describe LineItem do
  let(:item) { Fabricate(:line_item) }
  describe "#subtotal" do
    it "returns the subtotal of the line item" do
      item.subtotal.should == BigDecimal.new(item.quantity.to_f * item.price.to_f,2)
    end
  end
end
