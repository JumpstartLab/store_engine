require 'spec_helper'

describe OrderItem do

  let!(:product) { Product.create(id: 1, price: 2) }
  let!(:line_item) { LineItem.create(id: 1, quantity: 2, product: product) }
  let!(:order_item) { OrderItem.create(id: 1, line_item: line_item) }
  
  describe "#price" do
    it "sets the order item's price from the line_item price" do
      order_item.price.should == 2
    end
  end

  describe "#quantity" do
    it "sets the order_item's quantity from the line_item's quantity" do
      order_item.quantity.should == 2
    end
  end

  describe "#subtotal" do
    it "sets the subtotal from price and quantity" do
      order_item.subtotal.should == 4
    end
  end
end
