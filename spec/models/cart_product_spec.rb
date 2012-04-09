require 'spec_helper'

describe CartProduct do
  let!(:cart_product) do
    c = FactoryGirl.create(:cart)
    p = FactoryGirl.create(:product)
    FactoryGirl.create(:cart_product, :product => p, :cart => c)
  end
  it "updates the quantity" do
    cart_product.update_quantity(20)
    cart_product.quantity.should == 20
  end
end
