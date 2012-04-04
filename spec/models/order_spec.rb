require 'spec_helper'

describe Order do
  let(:order) { Fabricate :order }
  let(:product) { Fabricate :product }

  context "#total" do
    it "calculates the total price of its products" do
      order.add_product(product)
      order.add_product(product)
      order.total.should == product.price * 2
    end
  end

  context "#subtotal" do
    it "returns the subtotal of all similar order products" do
      order.add_product(product)
      order.add_product(product)
      order.add_product(product)
      order.subtotal(product).should == product.price * 3     
    end
  end

  context "#quantity_for" do
    it "returns the quantity of all similar products" do
      order.add_product(product)
      order.add_product(product)
      order.add_product(product)
      order.quantity_for(product).should == 3
    end
  end
end
