require 'spec_helper'

describe BillingMethod do
  describe ".find_by_order_id" do
    it "returns the billing method related to the order passed in" do
      billing = Fabricate(:billing_method)
      order = Fabricate(:order)
      order.update_attribute(:billing_method_id, billing.id)
      BillingMethod.find_by_order_id(order.id).should == billing
    end
  end

end
