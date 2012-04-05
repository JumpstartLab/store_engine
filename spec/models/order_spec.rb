require 'spec_helper'

describe Order do
  let(:order) {FactoryGirl.build(:order)}

  context "#status" do
    it "should have pending as default status" do
      order.status.should == "pending"
    end

    it "should update to cancel if pending" do
      order.next_status.should == "cancelled"
    end
 
    it "should update to shipped if paid" do
      order.status = "paid"
      order.next_status.should == "shipped"
    end

    it "should update to returned if shipped" do
      order.status = "shipped"
      order.next_status.should == "returned"
    end
  end


end
