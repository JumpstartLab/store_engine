require 'spec_helper'

describe Order do
  let(:user)  { FactoryGirl.create(:user)  }
  let(:order) { FactoryGirl.create(:order, :user_id => user) }

  context "#user" do
    it "should return the user associated with the user" do
      order.user.should == user
    end    
  end
end
