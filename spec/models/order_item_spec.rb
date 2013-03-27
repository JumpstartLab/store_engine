require File.dirname(__FILE__) + '/../spec_helper'

describe OrderItem do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:order_item)).to be_valid
  end

  it 'is invalid without a product' do
    expect(FactoryGirl.build(:order_item, product: nil)).to_not be_valid
  end

  it 'is invalid without an order' do
    expect(FactoryGirl.build(:order_item, order: nil)).to_not be_valid
  end

  it 'is invalid without a valid unit price' do
    expect(FactoryGirl.build(:order_item, unit_price: nil)).to_not be_valid
    expect(FactoryGirl.build(:order_item, unit_price: 0)).to_not be_valid
    expect(FactoryGirl.build(:order_item, unit_price: 1.245)).to_not be_valid
    expect(FactoryGirl.build(:order_item, unit_price: 1.24)).to be_valid
  end

  it 'is invalid without an integer quantity above zero' do
    expect(FactoryGirl.build(:order_item, quantity: nil)).to_not be_valid
    expect(FactoryGirl.build(:order_item, quantity: 0)).to_not be_valid
    expect(FactoryGirl.build(:order_item, quantity: 1.5)).to_not be_valid
  end
end
