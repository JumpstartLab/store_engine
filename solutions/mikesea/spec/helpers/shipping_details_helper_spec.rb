require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ShippingDetailsHelper. For example:
#
# describe ShippingDetailsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ShippingDetailsHelper do
  describe("us_states") do
    it "returns an array of states" do
      us_states.class.should be Array
    end
  end

  describe("formatted_shipping_address") do
    it "returns a formatted shipping_address" do
      # formatted_shipping_address(@)
    end
  end
end
