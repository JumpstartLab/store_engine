require 'spec_helper'

describe Cart do

  let!(:product) do
    p = Product.new(price: 2, description: "sample", title: "yo-yo") 
    p.save
    p
  end

  let!(:cart) { Cart.create() }
 
  
  describe "#add_product(product_id)" do
    context "when the product hasn't been added before" do
      it "creates a line_item" do
        cart.add_product(1)
        cart.line_items.each do |line_item|
          line_item.product_id.should == 1
        end
      end
    end  
    
    context "when the product has been added before" do
      it "should increase the line_item's quantity by 1" do
        cart.add_product(1)
        cart.add_product(1)
        cart.line_items.each do |line_item|
          line_item.quantity.should == 2
        end
      end
    end   
  end

  describe "#total_price" do
    it "gives the entire price for all items (inc. quantities) in cart" do
      cart.add_product(1)
      cart.total_price.should == 2
    end
  end
end
