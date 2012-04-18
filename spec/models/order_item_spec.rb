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
  let(:product) { FactoryGirl.create(:product,
                              :price => 100 ) }
  let(:order_item) { FactoryGirl.create(:cart_item, 
                              :product => product,
                              :quantity => 10 ) }
  

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

  it "returns the quantity times the product price" do
    order_item.price.should == BigDecimal.new('1000');
  end
end