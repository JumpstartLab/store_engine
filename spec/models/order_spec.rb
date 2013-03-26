require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order, user: @user)
    @order_item = FactoryGirl.create(:order_item, order: @order)
  end

  it 'has a valid factory' do
    expect(@order).to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryGirl.build(:order, user: nil)).to_not be_valid
  end

  it 'is invalid without an order_item' do
    expect(FactoryGirl.build(:order, order_items: [])).to_not be_valid
  end

  xit 'should not be valid without belonging to a user' do
  end
end
