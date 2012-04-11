require 'spec_helper'

describe Activation do
  let!(:product) {Fabricate(:product)}

  it "retires a product" do
    activation = Activation.new(product.id)
    activation.activate
    Product.find_by_id(product.id).retired.should == false
  end

end
