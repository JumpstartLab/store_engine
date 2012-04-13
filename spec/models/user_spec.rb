require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }
  let(:address1) { Fabricate(:address) }
  let(:address2) { Fabricate(:address) }

  context "when creating a user" do
    it "creates a cart for the user" do
      user.cart.should_not == nil
      user.cart.should == Cart.find_by_user_id(user.id)
    end
  end

  context "when a user has a credit card" do
    before(:each) do
      user.credit_cards << CreditCard.new
      user.credit_cards << CreditCard.new
      user.save
    end

    it "can set a default credit card" do
      cc = user.credit_cards.first
      user.set_default_credit_card_by_id(cc.id)
      user.default_credit_card.should == cc
    end
    it "defaults the defaults to the user's last credit card" do
      user.default_credit_card.should == user.credit_cards.last
    end
  end

  context "when a user has addresses" do
    before(:each) do
      user.addresses << address1
      user.addresses << address2
      user.save
    end
    it "can set a default billing address" do
        #raise user.addresses.first.inspect
        billing = user.addresses.first
        user.set_default_billing_address_by_id(billing.id)
        user.default_billing_address.should == billing
    end

    it "defaults to the user's last address" do
        user.default_billing_address.should == user.addresses.last
    end

    it "can set a default shipping address" do
        shipping = user.addresses.first
        user.set_default_shipping_address_by_id(shipping.id)
        user.default_shipping_address.should == shipping
    end

    it "defaults to the user's last address" do
      user.default_shipping_address.should == user.addresses.last
    end
  end
end
