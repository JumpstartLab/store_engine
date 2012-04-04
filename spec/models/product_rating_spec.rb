require 'spec_helper'

describe ProductRating do
  let!(:user) do 
    FactoryGirl.create(:user)
  end
  let!(:product) do
    FactoryGirl.create(:product)
  end
  let!(:rating) do
    FactoryGirl.create(:product_rating, :user => user, :product => product)
  end
  context "assocations" do
    it "has a product" do
      rating.product.should be_a(Product)
    end
    it "has a user" do
      rating.user.should be_a(User)
    end
  end
  context "prevent faulty ratings" do
    it "should fail when under 0" do
      rating.rating = -1
      rating.save.should be_false
    end
    it "should fail when over 5" do
      rating.rating = 6
      rating.save.should be_false
    end
    it "should succeed when in the params" do
      rating.rating = 4
      rating.save.should be_true
    end
  end
end