require 'spec_helper'

describe CreditCard do
  let(:user)  { FactoryGirl.create(:user)  }
  let(:order) { FactoryGirl.create(:order, :user => user) }
  let(:credit_card) { FactoryGirl.create(:credit_card, :user => user) }

  context ".new" do
    it "should create a credit card attached to a user" do
      credit_card.user = user
      credit_card.user_id.should == user.id
    end

    it "should not save the credit card" do
      CreditCard.all.should be_empty
    end

    it "should require a user id" do
      CreditCard.new.save.should == false
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

    context "if stripe passes back an error" do
      before(:each){ Stripe::Customer.stub(:create).and_raise Stripe::InvalidRequestError.new("Error", "id") }

      it "should send a customer create error" do
        credit_card.should_receive(:send_customer_create_error).and_return(false)
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
      credit_card.add_details_from_stripe_card_token(stripe_card_token)
      # raise CreditCard.all.inspect
      # raise user.credit_cards.inspect
      CreditCard.all.count.should == 1
      CreditCard.last.user_id.should == user.id
      # user.credit_cards.should == [ credit_card ]
    end
  end

  context "#formatted_last_four" do
    let(:credit_card) { FactoryGirl.create(:credit_card, :user => user) }

    it "should return a formatted last four digits" do
      credit_card.formatted_last_four.should == "XXXX-XXXX-XXXX-#{credit_card.last_four}"
    end
  end

  context "#formatted_exp_date" do
    it "should return a formatted expiration date" do
      credit_card.formatted_exp_date.should == "05/15"
    end
  end

  context "#charge" do
    let(:json) { JSON.parse(IO.read('spec/fixtures/stripe_charge_success.json')) }

    before(:each){ credit_card.stub(:stripe_customer_token).and_return "tok_KM1feeMHDhSgiq" }

    it "sends a charge request to Stripe" do
      Stripe::Charge.should_receive(:create).and_return(json)
      credit_card.charge(1000)
    end

    context "if stripe passes back an error" do
      before(:each){ Stripe::Charge.stub(:create).and_raise Stripe::InvalidRequestError.new("Error", "id") }

      it "should send a charge create error" do
        credit_card.should_receive(:send_charge_error).and_return(false)
        credit_card.charge(1000)
      end
    end
  end
end
