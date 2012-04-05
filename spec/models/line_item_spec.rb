require 'spec_helper'

describe LineItem do
  let(:item) { Fabricate(:line_item) }
  describe "#subtotal" do
    it "returns the subtotal of the line item" do
      item.subtotal.should == item.quantity * item.price
    end
  end
end
