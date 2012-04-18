require 'spec_helper'

describe Order do

  context "#user" do
    let(:user)  { FactoryGirl.create(:user) }
    let(:order_product) { FactoryGirl.create(:order_product) }
    let(:order) { FactoryGirl.create(:order, :user => user, :order_products => [order_product]) }

    it "should return the user associated with the user" do
      order.user.should == user
    end    
  end

  context "#mark_as_paid" do
    let(:order_product) { FactoryGirl.create(:order_product) }
    let(:order) { FactoryGirl.create(:order, :order_products => [order_product]) }
    
    it "should update the order status to 'paid'" do
      order.mark_as_paid
      order.status.should == "paid"
    end
  end


  describe "#build_order_from_cart" do
    let(:product_one) { FactoryGirl.create(:product) }
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

  context "#save_credit_card" do
    context "if the order is invalid" do

    end

    context "if order is valid" do

      it "should attach a user to the credit card" do
        # user.credit_card.should be == credit_card
      end

      it "should create a credit card object" do
      end

      it "should "
    end

  end

end
