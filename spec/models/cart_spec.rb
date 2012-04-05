require 'spec_helper'

describe Cart do
  let(:cart)      { Cart.create }
  let(:product)   { Fabricate(:product)}
  let(:products)  {[product, Fabricate(:product)]}

  describe "#products" do
    context "when products have been added to the cart" do
      before(:each) do
        products.each do |product|
          cart.add_product_by_id(product.id)
        end
      end

      it "returns the products" do
        cart.products.count.should == products.count
        products.each do |product|
          cart.products.should include(product)
        end
      end
      describe "#remove_product_by_id" do
        it "removes the product from the cart" do
          expect do 
            cart.remove_product_by_id(product.id)
          end.to change {cart.products.count}.by(-1)
          cart.products.should_not include(product)
        end
      end
    end
  end

  describe "#add_product_by_id" do
    it "adds the product to the cart" do
      expect do
        cart.add_product_by_id(product.id)
      end.to change {cart.products.count}.by(1)
    end
  end
end
