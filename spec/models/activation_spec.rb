require 'spec_helper'

describe Activation do
  let!(:product) {Fabricate(:product)}

  it "reactivates a retired product" do
    product.retire
    a = product.activations.count
    product.activate

    Product.find_by_id(product.id).retired.should == false
    Product.find_by_id(product.id).activations.count.should == a + 1
  end

end
