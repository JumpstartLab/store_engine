require 'spec_helper'

describe Retirement do
  let(:product)  { FactoryGirl.create(:product)  }

  context "#new" do
    it "should attach a product to the object" do
      retirement = Retirement.new(product.id)
      retirement.product.should == product
    end    
  end

  context "#retire" do
    it "should update the product's retired field" do
      retirement = Retirement.new(product.id)
      retirement.retire
      Product.find(product.id).retired == true
    end
  end
end
