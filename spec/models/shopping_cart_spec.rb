require 'spec_helper'

describe ShoppingCart do

  describe "#add_item" do
    context "when adding item" do
      let(:product) { Fabricate(:product) }

      it "adds a cart item" do
        cart = ShoppingCart.new
        cart.add_item(product.id, 10, 100)
        cart.cart_items.length.should ==  1
        cart.cart_items.first.quantity == 10
        cart.cart_items.first.price.should == 100
      end
    end
  end
end
