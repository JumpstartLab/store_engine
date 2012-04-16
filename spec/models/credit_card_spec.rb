require 'spec_helper'

describe CreditCard do
  let(:user)  { FactoryGirl.create(:user)  }
  let(:order) { FactoryGirl.create(:order, :user_id => user) }

  context ".new" do
    it "should create a credit card attached to a user" do
      cc = CreditCard.new(user)
      cc.user_id.should == user.id
    end

    it "should not save the credit card" do
      CreditCard.all.should be_empty
    end

    it "should require a user id" do
      expect{ CreditCard.new }.to raise_error(ArgumentError)
    end
  end

  context "#stripe_get_customer_token" do
    let(:credit_card) { CreditCard.new(user) }
    let(:stripe_card_token) { "tok_KM1feeMHDhSgiq" }

    context "if stripe_card_token is set" do
      let(:json) { JSON.parse(IO.read('spec/fixtures/stripe_new_customer_success.json')) }

      it "should return a customer_token" do
        Stripe::Customer.should_receive(:create).and_return(json)
        credit_card.stripe_get_customer_token(stripe_card_token)
      end
    end
  end

  context "#add_details_from_stripe_card_token" do
    let(:credit_card) { CreditCard.new(user) }
    let(:stripe_card_token) { "tok_KM1feeMHDhSgiq" }
    let(:json) { JSON.parse(IO.read('spec/fixtures/stripe_new_customer_success.json')) }

    it "updates credit card information from the stripe card token" do
        Stripe::Customer.should_receive(:create).and_return(json)
        credit_card.add_details_from_stripe_card_token(stripe_card_token)
    end    
  end
end
