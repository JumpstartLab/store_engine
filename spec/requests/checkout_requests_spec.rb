require 'spec_helper'

describe "Order Summary" do
  context "When I am on the order summary page" do
    it "shows the shipping address for the order" do
      visit new_shipping_address_path
      fill_in "First name", :with => "Jeff"
      fill_in "Last name", :with => "Casimir"
      fill_in "Company", :with => "Jumpstart Lab"
      fill_in "Line 1", :with => "1445 New York Ave NW"
      fill_in "Line 2", :with => "First Floor!"
      fill_in "City", :with => "Washington"
      fill_in "State", :with => "DC"
      fill_in "Zipcode", :with => "20005"
      fill_in "Phone", :with => "555-555-5555"
      click_button("Create Shipping address")
      current_path.should == new_billing_address_path
      fill_in "First name", :with => "Jeff"
      fill_in "Last name", :with => "Casimir"
      fill_in "Company", :with => "Jumpstart Lab"
      fill_in "Line 1", :with => "1445 New York Ave NW"
      fill_in "Line 2", :with => "First Floor!"
      fill_in "City", :with => "Washington"
      fill_in "State", :with => "DC"
      fill_in "Zipcode", :with => "20005"
      fill_in "Phone", :with => "555-555-5555"
      click_button("Create Billing address")
      current_path.should == order_summary_path
    end
  end
end