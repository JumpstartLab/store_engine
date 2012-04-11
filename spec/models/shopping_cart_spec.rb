require 'spec_helper'

describe ShoppingCart do

  describe "#add_item" do
    context "when adding item" do
      let(:product) { Fabricate(:product) }
      let(:product2) { Fabricate(:product) }

      it "adds a cart item" do
        cart = ShoppingCart.new
        cart.add_item(product.id, 10)
        cart.cart_items.length.should ==  1
        cart.cart_items.first.quantity.should == 10
        cart.cart_items.first.price.should == product.price
      end
    end

    context "when adding duplicate items" do
      let!(:product) { Fabricate(:product) }
      let!(:cart) { Fabricate(:shopping_cart) }

      before(:each) do
        cart.add_item(product.id, 10)
        cart.add_item(product.id, 5)
      end

      it "has one item" do
        cart.cart_items.length.should == 1
      end

      it "combines quantity" do
        cart.cart_items.first.quantity.should == 15
      end
    end
  end

  describe "#remove_item" do
    context "when items exist in the cart" do
      let(:cart_item) { Fabricate(:cart_item) }
      let(:cart_item2) { Fabricate(:cart_item) }
      let(:cart_items) { [cart_item, cart_item2] }

      it "removes an item from the cart" do
        cart = Fabricate(:shopping_cart, :cart_items => cart_items)
        cart.cart_items.count.should == 2
        cart.remove_item(cart_item.id)
        cart.cart_items.count.should == 1
        cart.cart_items.include?(cart_item2).should == true
      end
    end
  end

  describe "#update_quantities" do
    let(:cart_item) { Fabricate(:cart_item, :quantity => 4) }
    let(:cart_item2) { Fabricate(:cart_item, :quantity => 7) }
    let(:cart_items) { [cart_item, cart_item2] }
    let!(:cart) { Fabricate(:shopping_cart, :cart_items => cart_items) }
    
    it "updates the quantity of multiple items" do
      cart.update_quantities({cart_item.id.to_s => "10", cart_item2.id.to_s => 12})
      cart.cart_items.first.quantity.should == 10
      cart.cart_items.second.quantity.should == 12
    end
  end

  describe "#total" do
    context "when viewing the cart" do
      let(:cart_item) { Fabricate(:cart_item, :quantity => 5, :price => "10.75") }
      let(:cart_item2) { Fabricate(:cart_item, :quantity => 3, :price => "2.21") }
      let(:cart_items) { [cart_item, cart_item2] }

      it "calculates the total price of the items in the cart" do
        cart = Fabricate(:shopping_cart, :cart_items => cart_items)
        cart.total.should == Money.new(6038, "USD")
      end

      it "calcluates the total as zero if the cart is empty" do
        cart = Fabricate(:shopping_cart)
        cart.total.should == Money.new(0)
      end
    end
  end
end
