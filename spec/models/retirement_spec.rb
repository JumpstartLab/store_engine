require 'spec_helper'

describe Retirement do
  let!(:product) {Fabricate(:product)}

  it "retires a product" do
    retirement = Retirement.new(product.id)
    retirement.retire
    Product.find_by_id(product.id).retired.should == true
  end

end
