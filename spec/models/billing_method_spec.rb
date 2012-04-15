require 'spec_helper'

describe BillingMethod do
  let(:billing) { Fabricate(:billing_method) }
  describe ".find_by_order_id" do
    it "returns the billing method related to the order passed in" do
      order = Fabricate(:order)
      order.update_attribute(:billing_method_id, billing.id)
      BillingMethod.find_by_order_id(order.id).should == billing
    end
  end
  describe "#has_user?" do
    it "returns true if there is a user and false if not" do
      billing.has_user?.should == false
      user = Fabricate(:user)
      billing.update_attribute(:user_id, user)
      billing.has_user?.should == true
    end
  end
end
