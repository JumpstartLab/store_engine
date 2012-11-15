require 'spec_helper'

describe Retirement do
  let!(:product) {Fabricate(:product)}

  it "retires a product" do
    a = product.retirements.count
    product.retire

    Product.find_by_id(product.id).retired.should == true
    Product.find_by_id(product.id).retirements.count.should == a + 1
  end

end
