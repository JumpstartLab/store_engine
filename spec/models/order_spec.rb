require 'spec_helper'

describe Order, :model => :order do
  let!(:status) { Fabricate(:status) }
  let(:order) { Fabricate(:order) }
  let(:cancelled) { StoreEngine::Status::CANCELLED }
  let(:shipped) { StoreEngine::Status::SHIPPED }
  let(:returned) { StoreEngine::Status::RETURNED }
  let(:paid) { StoreEngine::Status::PAID }

  context "#update_status" do
    it "changes pending status to cancelled" do
      order.should_receive(:status).and_return(status)
      cancelled_status = Fabricate(:status, :name => cancelled)

      Status.stub(:find_by_name).with(cancelled).and_return(cancelled_status)
      order.should_receive(:update_attributes).with(:status => cancelled_status)

      order.update_status
    end

    it "changes shipped to returned" do
      shipped_status = Fabricate(:status, :name => shipped)
      order.should_receive(:status).and_return(shipped_status)

      returned_status = Fabricate(:status, :name => returned)
      Status.stub(:find_by_name).with(returned).and_return(returned_status)

      order.should_receive(:update_attributes).with(:status => returned_status)
      order.update_status
    end

    it "changes paid to shipped" do
      paid_status = Fabricate(:status, :name => paid)
      order.should_receive(:status).and_return(paid_status)

      shipped_status = Fabricate(:status, :name => shipped)
      Status.stub(:find_by_name).with(shipped).and_return(shipped_status)

      order.should_receive(:update_attributes).with(:status => shipped_status)
      order.update_status
    end
  end

  context "#total" do
    it "returns the total of all cart items" do
      item = Fabricate(:order_item)
      item2 = Fabricate(:order_item)
      order.should_receive(:order_items).and_return([item, item2])
      order.total.should == Money.new(20000)
    end

    it "returns 0 if there are not cart items" do
      order.total.should == Money.new(0)
    end
  end

  describe "#remove_item" do
    context "when items exist in the order" do
      let(:order_item) { Fabricate(:order_item) }
      let(:order_item2) { Fabricate(:order_item) }
      let(:order_items) { [order_item, order_item2] }

      it "removes an item from the order" do
        order = Fabricate(:order, :order_items => order_items)
        order.order_items.count.should == 2
        order.remove_item(order_item.id)
        order.order_items.count.should == 1
        order.order_items.include?(order_item2).should == true
      end
    end
  end
end
