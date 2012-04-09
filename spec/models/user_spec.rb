require 'spec_helper'

describe User do
  context "when creating a user" do
    it "creates a cart for the user" do
      user = Fabricate(:user)
      user.save
      user.cart.should_not == nil
      user.cart.should == Cart.find_by_user_id(user.id)
    end

  end
end
