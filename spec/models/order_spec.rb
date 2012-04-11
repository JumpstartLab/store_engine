require 'spec_helper'

describe Order do
  let(:cart)      { Cart.create }
  let(:product)   { Fabricate(:product)}
  let(:products)  {[product, Fabricate(:product)]}

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


end
