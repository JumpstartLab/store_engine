require 'spec_helper'

describe Order do
  context "Generates new order" do
    let!(:user) do 
      FactoryGirl.create(:user, :password => "mike")
    end 
    let!(:products) do
      (1..4).map { FactoryGirl.create(:product)}
    end
    let!(:cart) do
      FactoryGirl.create(:cart, :user => user, :products => products)
    end
    let!(:order) do
      FactoryGirl.build(:order)
    end
    it "process_cart" do
      order.process_cart(cart)
      order.products.should have(4).products
    end
  end
end
