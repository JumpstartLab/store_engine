require 'spec_helper'

describe LineItem do

  let!(:product) { Product.create(id: 1, price: 2, title: "yo-yo") }
  let!(:line_item) { LineItem.create(id: 1, product: product, quantity: 2) }

  describe "#price" do
    it "sets the line item price from the product price" do
      line_item.price.should == 2
    end
  end

  describe "#subtotal" do
    it "sets the line item subtotal from the price and quantity" do
      line_item.subtotal.should == 4
    end
  end
end
