require 'spec_helper'

describe Order do
  let(:order) {Order.new(:id=>2, :status=>"shipped", :user_id=>3)}
  context "#status" do
    it "has a status" do
      order.status.should_not be_nil
    end
  end

  # context "#user_id" do
  #   o = Order.new
end
