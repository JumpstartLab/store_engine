require 'spec_helper'

describe OrderStatus do
  let(:order_status) { FactoryGirl.create(:order_status) }

  context "#update_status(action)" do
    context "when I pass in an updated status" do

      context "with valid attributes" do

        it "updates the order_status" do
          ['paid', 'cancelled', 'shipped', 'returned'].each do |s|
            order_status.update_status(s)
            order_status.status.should == s
          end
        end

      end

      context "with invalid attributes" do

        it "doesn't update the status" do
          ['pay', 'blerg', 'meow', 'hi mom'].each do |s|
            order_status.update_status(s)
            order_status.status.should_not == s
          end
        end
      end
    end
  end
end
