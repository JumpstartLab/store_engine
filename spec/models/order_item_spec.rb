require 'spec_helper'

describe OrderItem do

  let!(:product) { Product.create(id: 1, price: 2) }
  let!(:line_item) do
    li = LineItem.new(product: product)
    li.quantity = 2
    li.save
    li
  end
  let!(:order_item) { OrderItem.create(line_item: line_item) }
  
  describe "#set_price" do
    it "sets the order item's price from the line_item price" do
      order_item.set_price(line_item)
      order_item.price.should == 2
    end
  end

  describe "#set_product" do
    it "sets the order item product_id from the line_item product" do
      order_item.set_product(line_item)
      order_item.product_id.should == 1
    end
  end

  describe "#set_quantity" do
    it "sets the order_item's quantity from the line_item's quantity" do
      order_item.set_quantity(line_item)
      order_item.quantity.should == 2
    end
  end

  describe "#subtotal" do
    before(:each) do 
      order_item.price = 2
      order_item.quantity = 2
    end
    
    it "sets the subtotal from price and quantity" do
      order_item.subtotal.should == 4
    end
  end
end
