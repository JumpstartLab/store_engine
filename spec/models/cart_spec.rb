require 'spec_helper'

describe Cart do
  context "Totaling of the cart works" do
    let!(:products) do
      (1..4).map { FactoryGirl.create(:product, :price => 100)}
    end
    let!(:cart) do
      FactoryGirl.create(:cart, :products => products)
    end

    it "sums up the total" do
      cart.total_in_cart.should == 40000
    end
    
  end  
end
