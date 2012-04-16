require 'spec_helper'

describe Status do
  let(:status) { Status.create }
  it "is 'pending' on creation" do
    status.name.should == "pending"
  end

  it "updates pending status to paid" do
    status.change
    status.name.should == "paid"
  end

  it "updates paid status to shipped" do
    status.name = "paid"
    status.change
    status.name.should == "shipped"
  end

  it "updates shipped status to returned" do
    status.name = "shipped"
    status.change
    status.name.should == "returned"
  end

  it "can be changed to cancelled if pendding" do
    status.name = 'pending'
    status.cancel
    status.name.should == 'cancelled'
  end

  it "cannot be cancelled if status is not pending" do
    status.name = 'paid'
    status.cancel
    status.name.should == 'paid'
  end
end
