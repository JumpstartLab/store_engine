require 'spec_helper'

describe Order do
  let(:user)  { FactoryGirl.create(:user)  }
  let(:order) { FactoryGirl.create(:order, :user_id => user) }

  context "#user" do
    it "should return the user associated with the user" do
      order.user.should == user
    end    
  end

  context "#stripe_create_customer" do
    context "if stripe_card_token is not set" do
      it "should do nothing" do
        order.stripe_create_customer
        Stripe::Customer.should_not_receive(:create)
      end
    end

    context "if stripe_card_token is set" do
      before(:each){ order.stripe_card_token = "tok_KM1feeMHDhSgiq" }

      it "should create a customer_token" do
        order.stripe_create_customer
        Stripe::Customer.should_receive(:create)
      end
    end
  end

  context "#mark_as_paid" do
    it "should update the order status to 'paid'" do
      order.mark_as_paid
      order.status.should == "paid"
    end
  end

  context "#save_credit_card" do
    context "if the order is invalid" do

    end

    context "if order is valid" do
      it "should attach a user to the credit card" do
      end

      it "should create a credit card object" do
      end

      it "should "
    end

  end

end
