require 'spec_helper'

describe ShippingAddress do
  describe ".find_by_order_id" do
    it "returns the shipping address related to the order passed in" do
      shipping = Fabricate(:shipping_address)
      order = Fabricate(:order)
      order.update_attribute(:shipping_address_id, shipping.id)
      ShippingAddress.find_by_order_id(order.id).should == shipping
    end
  end
end
