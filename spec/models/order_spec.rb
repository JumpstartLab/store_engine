require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'has a valid factory' do
    expect(FactoryGirl.build(:order, user: @user)).to be_valid
  end

  it 'is invalid without a user' do
    expect(FactoryGirl.build(:order, user: nil)).to_not be_valid
  end

  it 'is invalid without a valid status' do
    expect(FactoryGirl.build(:order, user: @user, status: 'pending')).to be_valid
    expect(FactoryGirl.build(:order, user: @user, status: 'cancelled')).to be_valid
    expect(FactoryGirl.build(:order, user: @user, status: 'paid')).to be_valid
    expect(FactoryGirl.build(:order, user: @user, status: 'shipped')).to be_valid
    expect(FactoryGirl.build(:order, user: @user, status: 'returned')).to be_valid
    expect(FactoryGirl.build(:order, user: @user, status: nil)).to_not be_valid
    expect(FactoryGirl.build(:order, user: @user, status: 'abracadabra')).to_not be_valid
  end

  describe '.apply_filter' do
    before(:each) do
      product1 = FactoryGirl.create(:product, title: 'Sweaty Hair', description: 'Sticky')
      product2 = FactoryGirl.create(:product, title: 'Dancing Bird', description: 'Something')
      product3 = FactoryGirl.create(:product, title: 'Flocking Buffalo', description: 'Crossfit sweat')
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product1)]
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product2)]
      FactoryGirl.create(:order, user: @user).order_items = [FactoryGirl.create(:order_item, product: product3)]
    end

    it 'returns the matching orders based on title and description' do
      expect(Order.apply_filter(@user.id, 'sweat').count).to eq 2
    end

    it 'returns all orders if no search term given' do
      expect(Order.apply_filter(@user.id).count).to eq 3
    end
  end
end
