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

  context 'create_and_charge' do
#     it 'creates a new order' do
#       product = FactoryGirl.create(:product)

#       login_user @user
#       #create a cart for the user
#       session[:cart] = {product.id => '2'}
#       cart = Cart.new(session[:cart])
#       #user checks out the cart
#       order.create_and_charge(cart)
#       #that process creates a new order
    # end
  end
end
