
require 'spec_helper'

describe LineItem do

  let!(:product) { Product.create(id: 1, price: 2, title: "yo-yo") }
  let!(:line_item) do
    li = LineItem.new(product: product)
    li.quantity = 2
    li.save
    li
  end

  describe "#subtotal" do
    it "sets the line item subtotal from the price and quantity" do
      line_item.subtotal.should == 4
    end
  end
end
