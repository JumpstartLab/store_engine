require 'spec_helper'

describe CreditCard do
  let(:user)  { FactoryGirl.create(:user)  }
  let(:order) { FactoryGirl.create(:order, :user_id => user) }
  let(:credit_card) { CreditCard.new(user) }

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
    let(:stripe_card_token) { "tok_KM1feeMHDhSgiq" }
    let(:json) { JSON.parse(IO.read('spec/fixtures/stripe_new_customer_success.json')) }

    it "updates credit card information from the stripe card token" do
      Stripe::Customer.should_receive(:create).and_return(json)
      credit_card.add_details_from_stripe_card_token(stripe_card_token)

      credit_card.credit_card_type.should_not be_nil 
      credit_card.last_four.should_not be_nil 
      credit_card.exp_month.should_not be_nil 
      credit_card.exp_year.should_not be_nil 
      credit_card.stripe_customer_token.should_not be_nil 
    end

    it "saves the credit card to the database" do
      Stripe::Customer.should_receive(:create).and_return(json)
      x = credit_card.add_details_from_stripe_card_token(stripe_card_token)
      # raise CreditCard.all.inspect
      # raise user.credit_cards.inspect
      CreditCard.all.count.should == 1
      CreditCard.last.user_id.should == user.id
      # user.credit_cards.should == [ credit_card ]
    end

    # context "given invalid information" do
    #   it "prints the Stripe error to the log" do
    #     error = Stripe::InvalidRequestError.new("The card number is invalid", "id")
    #     Stripe::Customer.should_receive(:create).and_return(error)
    #     credit_card.should_receive(:send_charge_error)
    #     credit_card.add_details_from_stripe_card_token(stripe_card_token)
    #   end
    # end
  end

  context "#charge" do
    let(:json) { JSON.parse(IO.read('spec/fixtures/stripe_charge_success.json')) }

    before(:each){ credit_card.stub(:stripe_customer_token).and_return "tok_KM1feeMHDhSgiq" }

    it "sends a charge request to Stripe" do
      Stripe::Charge.should_receive(:create).and_return(json)
      credit_card.charge(1000)
    end

    context "given invalid information" do
      it "handles the Stripe error" do
        e = Stripe::InvalidRequestError.new("The card number is invalid", "id")
        Stripe::Charge.should_receive(:create).and_raise(e)
        # Rails.logger.should_receive(:error)
        # Rails.logger.should_receive(:error).with("Stripe error while charging customer: #{e.message}")
        credit_card.should_receive(:send_charge_error)
        credit_card.charge(1000)
      end
    end
  end
end
