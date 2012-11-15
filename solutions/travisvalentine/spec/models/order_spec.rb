require 'spec_helper'

describe Order do
  let(:cart)      { Cart.create }
  let(:product)   { Fabricate(:product)}
  let(:products)  {[product, Fabricate(:product)]}
  let(:address)   { Fabricate(:address) }
  let(:address2)  { Fabricate(:address) }
  let!(:order)     { Order.create }


  before(:each) do
    products.each do |product|
      cart.add_product_by_id(product.id)
    end
  end

  describe "#add_products_by_cart_id" do
    it "adds the products from the cart" do
      order = Order.new
      order.add_products_by_cart_id(cart.id)
      order.products.each do |product|
        cart.products.should include(product)
      end
    end
  end

  context "when there is an address on the order" do

    describe "#billing_address" do
      it "sets and finds an order's billing address" do
        order.billing_address = address
        order.save
        order.billing_address.should == address
      end
    end

    describe "#shipping_address" do
      it "sets and finds the shipping address" do
        order.shipping_address = address2
        order.save
        order.shipping_address.should == address2
      end
    end
  end
end
