require 'spec_helper'

describe OrderItem do
  before(:each) do
    @attr = {
      :quantity => 6,
      :unit_price => 450,
      :product_id => 2,
      :order_id => 1
    }
  end

  it "creates an order item based on valid attributes" do
    OrderItem.create!(@attr)
  end

  it "rejects quantities 0 and below" do
    negative_quantity = OrderItem.new(@attr.merge(:quantity => -2))
    negative_quantity.should_not be_valid
  end

  it "rejects unit prices 0 and below" do
    negative_price = OrderItem.new(@attr.merge(:unit_price => -3))
    negative_price.should_not be_valid
  end
end