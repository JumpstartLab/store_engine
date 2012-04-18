require 'spec_helper'

describe Order do
  let(:user)  { FactoryGirl.create(:user) }
  let(:product_one) { FactoryGirl.create(:product) }
  let(:order_product) { FactoryGirl.create(:order_product, :product => product_one) }
  let(:order) { FactoryGirl.create(:order, :user => user, :order_products => [order_product]) }


  context "#user" do
    it "should return the user associated with the user" do
      order.user.should == user
    end    
  end

  context "#mark_as_paid" do
    it "should update the order status to 'paid'" do
      order.mark_as_paid
      order.status.should == "paid"
    end
  end

  describe "#build_order_from_cart" do
    let(:cart_product) { FactoryGirl.create(:cart_product, :product => product_one) }
    let(:cart) { FactoryGirl.create(:cart, :cart_products => [cart_product] )}
    let(:order) { FactoryGirl.build(:order) }

    it "creates order products and attaches them to order" do
      order.build_order_from_cart(cart)
      order.products == cart.cart_products
    end

    context "when there are items in the cart with quantity > 1" do
      let(:cart_product) { FactoryGirl.create(:cart_product, :product => product_one, :quantity => 2) }

      it "creates order products with quantity 2" do
        order.build_order_from_cart(cart)
        order.save
        order.order_products.find_by_product_id(1).quantity == 2
      end
    end
  end

  describe "#charge" do
    let(:credit_card){ FactoryGirl.create(:credit_card, :user => user) }
    let(:product_one) { FactoryGirl.create(:product) }
    let(:cart_product) { FactoryGirl.create(:cart_product, :product => product_one) }
    let(:cart) { FactoryGirl.create(:cart, :cart_products => [cart_product] )}

    context "if charge is sucessful" do
      before do
        credit_card.stub(:charge).and_return(true)
        order.credit_card = credit_card
      end

      it "should call #mark_as_paid and return true" do
        order.should_receive(:mark_as_paid)
        order.charge(cart).should == true
      end
    end

    context "if charge is unsucessful" do
      before do
        credit_card.stub(:charge).and_return(false)
        order.credit_card = credit_card
      end

      it "should return false" do
        order.charge(cart).should == false
      end
    end
  end

  describe "#set_cc_from_stripe_customer_token" do
    let!(:credit_card){ FactoryGirl.create(:credit_card, :user => user) }

    it "should return a credit card matching a given stripe customer token" do
      order.set_cc_from_stripe_customer_token("tok_KM1feeMHDhSgiq")
      order.credit_card_id.should == credit_card.id
    end
  end

  describe "#order_total" do
    it "should return the total of the order" do
      order.order_total.should == product_one.price
    end

    context "if there are two items in the order" do
      before do
        order_product.quantity = 2
      end

      it "should return the total of the order" do
        order.order_total.should == product_one.price * 2
      end
    end
  end

  describe ".orders_by_status" do
    let(:order_status_one) { OrderStatus.new( :status => 'pending' ) }
    let(:order_status_two) { OrderStatus.new( :status => 'pending' ) }
    let(:order_two) { FactoryGirl.create(:order, :user => user, :order_products => [order_product]) }

    before do
      order.order_status = order_status_one
      order_two.order_status = order_status_two
    end

    context "when no parameter is passed in" do
      it "should return all the orders" do
        Order.orders_by_status.should == Order.all
      end
    end

    context "when an order status is passed in" do
      it "should return all the orders with a given status" do
        Order.orders_by_status('pending').should include order
        Order.orders_by_status('pending').should include order_two
        Order.orders_by_status('pending').size.should == 2
      end

      context "when one order status changes" do
        before do
          order_two.order_status.update_attribute(:status, 'paid')
        end

        it "should return only the orders with a given status" do
          Order.orders_by_status('pending').should include order
          Order.orders_by_status('pending').size.should == 1
          Order.orders_by_status('paid').should include order_two
          Order.orders_by_status('paid').size.should == 1
        end
      end
    end

    describe ".user_by_order_id" do
      it "returns the user given an order id" do
        Order.user_by_order_id(order.id).should == user
      end
    end
  end
end
