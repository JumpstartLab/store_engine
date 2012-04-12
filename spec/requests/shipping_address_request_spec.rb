require 'spec_helper'

describe "Shipping Address Requests" do
  context "When I submit my shipping address" do
    it "takes me to the new billing address page" do
      visit new_shipping_address_path
      click_button("Create Shipping address")
      current_path.should == new_billing_address_path
    end
  end

end