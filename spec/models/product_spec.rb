require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product)}  
  context "Product is only hidden on delete" do
    it "destroys hidden product" do
      product.destroy
      product.active.should == 0
    end
  end
  context "Product can have an image uploaded from URL" do
    it "uploads image" do
      product.avatar_from_url("http://goo.gl/8yWSX")
      product.save
    end
  end
end
