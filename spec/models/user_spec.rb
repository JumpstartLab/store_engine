require 'spec_helper'

describe User do
  let!(:user) do 
    FactoryGirl.create(:user)
  end
  let!(:products) do
    (1..3).map { FactoryGirl.create(:product)}
  end
  let!(:order) do
    FactoryGirl.create(:order, :products => products, :user => user)
  end
  let!(:ratings) do
    (1..5).map { FactoryGirl.create(:product_rating, :user => user)}
  end
  context "User has orders" do
    it "has orders" do
      user.orders.count.should == 1
    end
    it "has 3 prodcuts in the first order" do
      user.products.count.should == 3
    end
  end
  context "user has ratings" do
    it "has ratings" do
      user.product_ratings.should have(5).ratings
    end
  end
end