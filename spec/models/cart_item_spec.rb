require 'spec_helper'

describe CartItem do
  
  let(:product) { FactoryGirl.create(:product,
                              :price => 100 ) }
  let(:cart_item) { FactoryGirl.create(:cart_item, 
                              :product => product,
                              :quantity => 10 ) }

  it "requires a quantity that is a number" do
    cart_item.quantity = "b"
    cart_item.should_not be_valid
  end

  describe "#price" do
    it "calculates the correct price based on the quantity" do
      cart_item.price.should == 1000
    end
  end

  describe "#individual_price" do
    it "fetches the price of the product" do
      cart_item.individual_price.should == product.price
    end
  end
end

