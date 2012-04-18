require 'spec_helper'

describe Cart do
  let (:cart)     { Cart.create }
  let (:product_1)  { FactoryGirl.create(:product, 
                    price: 200.00) }
  let (:product_2)  { FactoryGirl.create(:product, 
                    price: 100.00) }
  let (:products) { [product_1, product_2] }

  describe "#items" do
    context "when items have been added to the cart" do
      before(:each) { products.each { |p| cart.add_product(p) } }

      it "returns the items" do
        cart.items.count.should == products.count
        products.each do |p|
          cart.items.should include(p)
        end
      end

      it "increments the quantity when given an existing item" do
        cart.add_or_increment_by_product(product_1.id)
        cart.cart_items.first.quantity.should == 2
      end
    end
    
  context "when items have been added to the cart" do
    before(:each) { products.each { |p| cart.add_product(p) } }
    
      describe "#total_price" do
        it "returns the total price for each item in the cart" do
          cart.total_price.should == BigDecimal.new("300")
        end      
        
        it "returns the total price based on quantity" do
          cart.add_or_increment_by_product(product_1.id)
          cart.total_price.should == BigDecimal.new("500")
        end 
      end
    
      describe "quantity" do
        it "returns the total quantity of items in the cart" do
          cart.add_or_increment_by_product(product_1.id)
          cart.quantity.should == 3
        end
      end
    end
  end
  
  
end
