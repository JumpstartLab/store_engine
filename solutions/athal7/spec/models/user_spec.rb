require 'spec_helper'

describe User do

  [:email_address, :full_name, :display_name].each do |attr|
    it "has an attribute #{attr}" do
      User.new.should respond_to(attr)
    end
  end

  context "valid attributes" do
    let(:user) { Fabricate(:user) }

    context "presence of" do
      it "is valid with valid attributes" do
        user.should be_valid
      end

      it "is not valid without a email_address" do
        user.email_address = nil
        user.should_not be_valid
      end

      it "is not valid without a full_name" do
        user.full_name = nil
        user.should_not be_valid
      end

      it "is valid without a display_name" do
        user.display_name = nil
        user.should be_valid
      end
    end

    context "type validations" do
      it "does not allow a duplicate email_address to be created" do
        first_user = {email_address: "a@a.com", full_name: "b"}
        first_user = {email_address: "a@a.com", full_name: "c"}
        User.create(first_user)
        User.create(first_user).should_not be_valid
      end

      it "does not accept an invalid email address" do
        user.email_address = "blah"
        user.should_not be_valid
      end

      it "does not accept a display name that is too short or too long" do
        user.display_name = "a"
        user.should_not be_valid

        user.display_name = "asdijvba;iowejb;oiajrb;oiweaje;biajwe;bijawe"
        user.should_not be_valid
      end

    end
  end

  describe "pending_order" do
    let!(:user) { Fabricate(:user) }
    let!(:billing) do
      billing = Fabricate(:billing_method)
      billing.user_id = user.id
      billing.save
      billing
    end
    let!(:order) do
      ord = Fabricate(:order)
      ord.status = "paid"
      ord.user_id = user.id
      ord.billing_method_id = billing.id
      ord.save
      ord
    end
    let!(:other_order) do
      ord = Fabricate(:order)
      ord.status = "pending"
      ord.user_id = user.id
      ord.billing_method_id = billing.id
      ord.save
      ord
    end
    context "if there is a pending order for that user" do
      it "returns the pending order for the user" do
        user.pending_order.should == other_order
      end
    end
    context "if there are no pending orders for the user" do
      it "returns nil" do
        other_order.status = "paid"
        other_order.save
        user.pending_order.should == nil
      end
    end
  end
  describe "#shipping_address_id" do
    it "returns the shipping address id for the user" do
      shipping = Fabricate(:shipping_address)
      user = Fabricate(:user)
      shipping.update_attribute(:user_id, user.id)
      user.shipping_address_id.should == shipping.id
    end
  end
  describe "#billing_method_id" do
    it "returns the billing method id for the user" do
      billing = Fabricate(:billing_method)
      user = Fabricate(:user)
      billing.update_attribute(:user_id, user.id)
      user.billing_method_id.should == billing.id
    end
  end

end