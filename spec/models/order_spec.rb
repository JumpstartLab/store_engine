require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  before(:each) do
    @user = User.new(email: "blah@blah.com", full_name: "hihi")
    @order = @user.orders.new()
    @order_item = @order.order_items.new(product_id: 1)
  end

  it "should be valid" do
    expect(@order).to be_valid
  end

  xit "should not be valid without an associated product" do
  end

  xit "should not be valid without belonging to a user" do
  end

  xit "should not be valid without belonging to a user" do
  end
end
