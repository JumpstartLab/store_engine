# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  status     :string(255)
#  address_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

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
      order.total.should be_within(0.001).of(product.price * 3)
    end
  end

  context "#subtotal" do
    it "returns the subtotal of all similar order products" do
      order.subtotal(product).should be_within(0.001).of(product.price * 3)
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
