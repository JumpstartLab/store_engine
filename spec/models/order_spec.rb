require 'spec_helper'

describe Order do
  let!(:ord) { Fabricate(:order) }
  describe "#user" do
    it "returns the user associated with the order" do
      fake_user = Fabricate(:user)
      ord.user_id = fake_user.id
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

  describe "#next_transition" do
    it "returns the proper next status" do
      ord.update_attributes(status: "pending")
      ord.next_transition.should == "paid"
      ord.update_attributes(status: "paid")
      ord.next_transition.should == "shipped"
      ord.update_attributes(status: "")
      ord.next_transition.should == "pending"
    end
  end

  describe "#user_name" do
    it "returns the display name of the order's user" do
      fake_user = Fabricate(:user)
      ord.user_id = fake_user.id
      ord.user_name.should == fake_user.display_name
    end
  end

  describe "#user_email_address" do
    it "returns the email address of the order's user" do
      fake_user = Fabricate(:user)
      ord.user_id = fake_user.id
      ord.user_email_address.should == fake_user.email_address
    end
  end

  describe "#has_product?" do
    it "returns a bool of whether the order has a product" do
      prod = Fabricate(:product)
      ord.has_product?(prod.id).should == false
      LineItem.create(order_id: ord.id, product_id: prod.id)
      ord.has_product?(prod.id).should == true
    end
  end
end
