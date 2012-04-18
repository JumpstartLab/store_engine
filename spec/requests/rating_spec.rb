require 'spec_helper'

describe "Product Rating", :focus => true do
  let!(:product) { FactoryGirl.create(:product)}   
  let!(:user) { FactoryGirl.create(:user, :password => "mike")}
  let!(:user2) { FactoryGirl.create(:user, :password => "mike")}
  let!(:valid_rating) { FactoryGirl.create(:product_rating, :user => user, :product => product)}
  let!(:invalid_rating) { FactoryGirl.create(:product_rating, :user => user, :product => product, :created_at => 15.days.ago)}
  let!(:invalid_rating2) { FactoryGirl.create(:product_rating, :user => user2, :product => product, :created_at => 15.days.ago)}
  let!(:order) do
    FactoryGirl.create(:order, :products => [product], :user => user)
  end 
  context "Can submit ratings while logged in" do
    before(:each) do
      login(user)
    end  
    context "visit product path" do  
      before(:each) do
        visit product_path(product)
        fill_in "product_rating[name]", :with => "Amazing"
      end
      it "submit tweet with success" do
        fill_in "product_rating_body", :with => "This product is awesome!"
        choose("product_rating_rating_3")
        click_on "Create Product rating"
        page.should have_content(user.name)
        page.should have_content("Comment successfully added")
      end
      it "validation errors" do
        fill_in "product_rating_body", :with => ""
        choose("product_rating_rating_3")
        click_on "Create Product rating"
        page.should have_content(user.name)
        page.should have_content("There was an error with your comment")
      end
    end
  end
  context "Can't rate while not logged in" do
    it "can not see content" do
      visit product_path(product)
      page.should_not have_content "New Comment"
    end
  end
  context "Edit their ratings" do
    before(:each) do
      login(user)
    end
    it "Can edit if within 15 minutes" do
      visit edit_product_product_rating_path(product, valid_rating)
      click_on("Update Product rating")
      page.should have_content product.name
    end
    it "Can't edit after 15 minutes" do
      visit edit_product_product_rating_path(product, invalid_rating)
      page.should have_content "It has been too long to edit this review"
    end
    it "Can't edit someone else rating" do
      expect{ visit edit_product_product_rating_path(product, invalid_rating2)}.to raise_error
    end

  end
end