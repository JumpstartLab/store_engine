require 'spec_helper'

describe Order do
  let(:test_order) {Order.create}

  describe "status_options" do
    it "is an array of options" do
      test_order.status_options.class.to_s.should == "Array"
    end
  end

end
