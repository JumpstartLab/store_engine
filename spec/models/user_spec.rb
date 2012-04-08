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
        user_1 = {email_address: "a@a.com", full_name: "b"}
        user_2 = {email_address: "a@a.com", full_name: "c"}
        User.create(user_1)
        User.create(user_2).should_not be_valid
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
    let!(:user1) { Fabricate(:user) }
    let!(:billing1) do
      b = Fabricate(:billing_method)
      b.user_id = user1.id
      b
    end
    let!(:order1) do
      o1 = Fabricate(:order)
      o1.status = "paid"
      o1.user_id = user1.id
      o1.billing_method_id = billing1.id
      o1
    end
    let!(:order2) do
      o2 = Fabricate(:order)
      o2.status = "pending"
      o2.user_id = user1.id
      o2.billing_method_id = billing1.id
      o2
    end
    context "if there is a pending order for that user" do
      it "returns the pending order for the user" do
        user1.pending_order.should == order2
      end
    end
    context "if there are no pending orders for the user" do
      it "returns nil" do
        order2.status = "paid"
        user1.pending_order.should == nil
      end

    end
  end
end