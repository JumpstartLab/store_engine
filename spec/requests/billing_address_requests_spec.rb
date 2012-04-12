require 'spec_helper'

describe "Billing Address Requests" do
  context "When I submit my billing address" do
    it "takes me to the order summary page" do
      visit new_billing_address_path
      click_button("Create Billing address")
      current_path.should == order_summary_path
    end
  end

end