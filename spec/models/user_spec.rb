require 'spec_helper'

describe User do
  let!(:user) do 
    FactoryGirl.create(:user)
  end
  let!(:user2) do 
    FactoryGirl.create(:user)
  end  
  let!(:products) do
    (1..3).map { FactoryGirl.create(:product)}
  end
  let!(:order) do
    FactoryGirl.create(:order, :products => products, :user => user)
  end
  let!(:cart) do
    FactoryGirl.create(:cart, :products => products, :user => user)
  end
  let!(:ratings) do
    (1..5).map { FactoryGirl.create(:product_rating, :user => user, :product => products.first)}
  end
  context "User edit" do
    it "can't update permission" do
      lambda { user.update_attributes({"permission" => 9}) }.should raise_error
    end
    it "is a user" do
      user.user.should == true
    end
  end  
  context "User has orders" do
    it "has orders" do
      user.orders.count.should == 1
    end
    it "has 3 prodcuts in the first order" do
      user.products.count.should == 3
    end
    context "User can charge order" do
      it "Cart converts to order" do
        order = Order.process_cart(cart)
        order.should be_a(Order)
      end
    end
  end
  context "user has ratings" do
    it "has ratings" do
      user.product_ratings.should have(5).ratings
    end
  end
  context "User can become inactive" do
    it "can't login" do
      user.destroy
      user.active.should == 0
    end
  end
end