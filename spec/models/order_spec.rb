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
end
