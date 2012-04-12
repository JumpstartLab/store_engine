require 'spec_helper'

describe Cart do

  let!(:product) { Product.create(id: 1, price: 2, title: "yo-yo") }
  let!(:product_2) { Product.create(id: 2, price: 4, title: "double-yo-yo") }
  let!(:line_item) { LineItem.create(id: 1, quantity: 2, product: product) }
  let!(:cart) { Cart.create(id: 1) }
 
  
  describe "#add_product_to_cart(product_id)" do
    context "when the product hasn't been added before" do
      it "creates a line_item" do
        cart.add_product(1)
        cart.line_items.each do |line_item|
          line_item.product_id.should == product.id
        end
      end
    end  
    context "when the product has been added before" do
      it "should increase the line_item's quantity by 1" do
        cart.add_product(1)
        cart.add_product(1)
        puts cart.line_items.inspect
        cart.line_items.each do |line_item|
          line_item.quantity.should == 2
        end
      end
    end  
  end
end
