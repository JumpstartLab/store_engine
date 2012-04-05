require 'spec_helper'

describe Order do
  let(:order) { Fabricate :order }
  let(:product) { Fabricate :product }

  before(:each) do
    order.add_product(product)
    order.add_product(product)
    order.add_product(product)
  end

  context "#total" do
    it "calculates the total price of its products" do
      order = Fabricate :order
      product = Fabricate :product
      order.add_product(product)
      order.add_product(product)

      order.total.should == product.price * 2
    end
  end

  context "#subtotal" do
    it "returns the subtotal of all similar order products" do
      order.subtotal(product).should == product.price * 3     
    end
  end

  context "#quantity_for" do
    it "returns the quantity of all similar products" do
      order.quantity_for(product).should == 3
    end
  end

  context "#items" do
    it "returns a collection" do
      order.items.should be_a Enumerable
    end

    it "returns a collection of order items" do
      order.items.sample.should be_a OrderItem
    end
  end
end
