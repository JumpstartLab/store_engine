require 'spec_helper'

describe LineItem do
  let(:item) { Fabricate(:line_item) }
  describe "#subtotal" do
    it "returns the subtotal of the line item" do
      float_sub_total = item.quantity.to_f * item.price.to_f
      item.subtotal.should == BigDecimal.new(float_sub_total,2)
    end
  end

  describe "#increment_quantity" do
    it "increments the quantity of the line item" do
      item.increment_quantity(1)
      item.quantity.should == 2
    end
  end

  describe "#increment_or_create_line_item" do
    let(:ord) { Fabricate(:order) }
    let(:prod) { Fabricate(:product) }
    context "when a line item for the product doesn't exist" do
      it "creates a new line item for the product" do
        LineItem.increment_or_create_line_item(order_id: ord.id,
                                               product_id: prod.id)
        LineItem.all.size.should == 1
      end
    end
    context "when a line item for the product exists" do
      it "increments quantity of the line item" do
        LineItem.increment_or_create_line_item({order_id: ord.id,
                                                product_id: prod.id,
                                                quantity: 1})
        line_item = LineItem.last
        LineItem.increment_or_create_line_item({order_id: ord.id,
                                                product_id: prod.id,
                                                quantity: 1})
        updated_item = LineItem.find(line_item.id)
        updated_item.quantity.should == 2
      end
    end
  end
  describe "#clean_price" do
    it "returns a big decimal of the price" do
      item.clean_price.should == BigDecimal.new(item.price,2)
    end
  end
end
