require 'spec_helper'

describe "Dashboard" do
  let(:dashboard) { Dashboard.new }

  context "#total_pending_orders" do
    context "when there are pending orders" do
      let!(:status) { Fabricate(:status) }
      let!(:order) { Fabricate(:order, :status => status) }
      let!(:order1) { Fabricate(:order, :status => status) }

      it "returns 2" do
        dashboard.total_pending_orders.should == 2
      end
    end

    context "when there are no pending orders" do
      it "returns 0" do
        dashboard.total_pending_orders.should == 0
      end
    end
  end

  context "#total_cancelled_orders" do
    context "when there are orders" do
      let!(:status) { Fabricate(:status, :name => StoreEngine::Status::CANCELLED) }
      let!(:order) { Fabricate(:order, :status => status) }
      let!(:order1) { Fabricate(:order, :status => status) }

      it "returns 2" do
        dashboard.total_cancelled_orders.should == 2
      end
    end

    context "when there are no orders" do
      it "returns 0" do
        dashboard.total_cancelled_orders.should == 0
      end
    end
  end

  context "#total_paid_orders" do
    context "when there are orders" do
      let!(:status) { Fabricate(:status, :name => StoreEngine::Status::PAID) }
      let!(:order) { Fabricate(:order, :status => status) }
      let!(:order1) { Fabricate(:order, :status => status) }

      it "returns 2" do
        dashboard.total_paid_orders.should == 2
      end
    end

    context "when there are no orders" do
      it "returns 0" do
        dashboard.total_paid_orders.should == 0
      end
    end
  end

  context "#total_shipped_orders" do
    context "when there are orders" do
      let!(:status) { Fabricate(:status, :name => StoreEngine::Status::SHIPPED) }
      let!(:order) { Fabricate(:order, :status => status) }
      let!(:order1) { Fabricate(:order, :status => status) }

      it "returns 2" do
        dashboard.total_shipped_orders.should == 2
      end
    end

    context "when there are no orders" do
      it "returns 0" do
        dashboard.total_shipped_orders.should == 0
      end
    end
  end

  context "#total_returned_orders" do
    context "when there are orders" do
      let!(:status) { Fabricate(:status, :name => StoreEngine::Status::RETURNED) }
      let!(:order) { Fabricate(:order, :status => status) }
      let!(:order1) { Fabricate(:order, :status => status) }

      it "returns 2" do
        dashboard.total_returned_orders.should == 2
      end
    end

    context "when there are no orders" do
      it "returns 0" do
        dashboard.total_returned_orders.should == 0
      end
    end
  end
end

