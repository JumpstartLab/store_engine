require 'spec_helper'

describe Order do
  let(:test_user) { FactoryGirl.create(:user) }
  let(:address) { FactoryGirl.create(:address) }
  let(:test_user) { FactoryGirl.create(:user, :addresses => [address]) }
  let(:test_products) do
    (1..5).map { FactoryGirl.create(:product) }
  end

  let(:order_item_1) { FactoryGirl.create(:order_item, :unit_price => 100, :quantity => 2) }
  let(:order_item_2) { FactoryGirl.create(:order_item, :unit_price => 200, :quantity => 2) }
  let(:oo) { [order_item_1, order_item_2] }
  let(:order) { FactoryGirl.create(:order, :order_items => oo, :user => test_user) }
  
  before(:each) do
    @attr = {
      user: test_user,
      products: test_products
    }
  end
  
  it "should create an order given valid attributes" do
    Order.create(@attr)
  end

  it "should have a status" do
    order.current_status.should_not == nil
  end

  it "should have a default status of 'pending'" do
    order.current_status.should == "pending"
  end

  describe "#total_price" do
    it "gets the correct total price of the order" do
      order.total_price.should == BigDecimal.new("600")
    end

    it "returns a BigDecimal" do
      order.total_price.should be_a BigDecimal
    end
  end

  describe "#total_price_in_cents" do
    it "returns a BigDecimal" do
      order.total_price.should be_a BigDecimal
    end

    it "gets the correct total price of the order in cents" do
      order.total_price_in_cents.should == BigDecimal.new("60000")
    end
  end

  describe "#add_order_items_from" do
    let (:cart)     { Cart.create }
    let (:products) { [product_1, product_2] }
    let (:new_order) { FactoryGirl.create(:order) }

    before(:each) { test_products.each { |p| cart.add_product(p) } }
    it "matches the cart_items to order_items" do
      new_order.add_order_items_from(cart)
      new_order.total_price.should == cart.total_price
    end
  end

  describe "#create_stripe_user" do
    it "saves the token to the user" do
      customer = Stripe::Customer.create(
        :description => "Customer for christopher.anderson@gmail.com",
        :card => {
        :number => "4242424242424242",
        :exp_month => 4,
        :exp_year => 2013,
        :cvc => 314
      },)
      Stripe::Customer.stub!(:create).and_return(customer) 
      order.create_stripe_user(valid_card_data)
      test_user.stripe_id = customer.id
      test_user.stripe_id.should == customer.id
    end
  end
end
