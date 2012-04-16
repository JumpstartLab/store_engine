require 'spec_helper'

describe Order do
  let(:test_user) { FactoryGirl.create(:user) }
  let(:test_products) do
    (1..5).map { FactoryGirl.create(:product) }
  end

  let(:order_item_1) { FactoryGirl.create(:order_item, :unit_price => 100, :quantity => 2) }
  let(:order_item_2) { FactoryGirl.create(:order_item, :unit_price => 200, :quantity => 2) }
  let(:oo) { [order_item_1, order_item_2] }
  let(:order) { FactoryGirl.create(:order, :order_items => oo) }
  
  before(:each) do
    @attr = {
      status: "pending",
      user: test_user,
      products: test_products
    }
  end
  
  it "should create an order given valid attributes" do
    Order.create(@attr)
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

end
