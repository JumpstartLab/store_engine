require 'spec_helper'

describe Order do
  let(:order) { FactoryGirl.create(:order) }

  context "#user" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) { user.add_order(order) }

    it "should return the user associated with the user" do
      order.user.should == user
    end    
  end
end
