require 'spec_helper'

describe Cart do
  let (:cart)     { Cart.create }
  let (:product)  { Fabricate(:product) }
  let (:products) { [product, Fabricate(:product)] }

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
        cart.add_or_increment_by_product(product.id)
        cart.cart_items.first.quantity.should == 2
      end

      it "increments the quantity given a product id" do
        cart.increment_quantity_for(product.id)
        cart.cart_items.first.quantity.should == 2
      end
    end
  end
end
