require 'spec_helper'

describe "Product Rating", :focus => true do
  let!(:product) { FactoryGirl.create(:product)}   
  let!(:user) { FactoryGirl.create(:user, :password => "mike")}
  let!(:order) do
    FactoryGirl.create(:order, :products => [product], :user => user)
  end 
  context "Can submit ratings while logged in" do
    before(:each) do
      login(user)
    end    
    it "visit product path and submit tweet with success" do
      visit product_path(product)
      fill_in "product_rating[name]", :with => "Amazing"
      fill_in "product_rating_body", :with => "This product is awesome!"
      choose("product_rating_rating_3")
      click_on "Create Product rating"
      page.should have_content(user.name)
      page.should have_content("Comment successfully added")
    end
  end
  context "Can't rate while not logged in" do
    it "can not see content" do
      visit product_path(product)
      page.should_not have_content "New Comment"
    end
  end
end