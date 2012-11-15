require 'spec_helper'

describe OrderProduct do
  let!(:order_product) do
    u = FactoryGirl.create(:user)
    p = FactoryGirl.create(:product)
    o = FactoryGirl.create(:order, :products => [p], :user => u)

    FactoryGirl.create(:order_product, :order => o, :product => p)
  end
  it "updates the quantity" do
    order_product.update_quantity(20)
    order_product.quantity.should == 20
  end
end
