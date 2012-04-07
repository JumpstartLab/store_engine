require 'spec_helper'

describe Order do
  let!(:ord) { Fabricate(:order) }
  describe "#user" do
    it "returns the user associated with the order" do
      fake_user = Fabricate(:user)
      fake_user.id = ord.user_id
      ord.user.should == fake_user
    end
  end
  describe "#amount" do
    it "returns the total of the order" do
      pending
      actual_total = 0
      li = {}
      3.times do |t|
        li[t] = Fabricate(:line_item)
        li[t].order_id = ord.id
        actual_total += li[t].subtotal
      end
      ord.amount.should == actual_total
    end
  end
end
