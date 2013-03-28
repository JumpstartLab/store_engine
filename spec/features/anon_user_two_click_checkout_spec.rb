require 'spec_helper'


describe "two click checkout process" do
  after(:each) do
    Product.all.clear
    User.all.clear
  end

  context "when the user is anonymous" do
    it "should not have a two click checkout option" do
      FactoryGirl.create(:product)
      visit '/products/1'
      page.should_not have_button('2-Click')
    end
  end

  context "when the user is logged in" do
    it "should have a two click checkout option" do
      FactoryGirl.create(:user)
      FactoryGirl.create(:product)
      visit '/login'
      fill_in "sessions_email", with: "raphael@example.com"
      fill_in "sessions_password", with: "password"
      click_button "Login"
      visit '/products/1'
      page.should have_button('2-Click')
    end
  end
end