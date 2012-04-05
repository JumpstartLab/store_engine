require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product)}  
  context "Product is only hidden on delete" do
    it "destroys hidden product" do
      product.destroy
      product.active.should == 0
    end
  end
end
