require 'spec_helper'

describe "Test Auth" do
  describe "Not Logged in" do
    it "Prevent Visit to Admin Area" do
      visit "/dashboard"
      page.should have_content("Login")
    end 
  end
  describe "logged in admin" do 
    let!(:user) do
      FactoryGirl.create(:admin, :password => "mike")
    end

    before(:each) do
     visit '/login'
     fill_in 'user[email]', :with => user.email
     fill_in 'user[password]', :with => "mike"
     click_button("Sign In")
    end

    it "Visit Admin Area" do
     visit "/dashboard"
     page.should have_content("Dashboard")
    end   
  end
  describe "logged in user" do
    it "logs a user in" do
      pending
    end
  end
  describe "log out a user" do
    let!(:user) do
      FactoryGirl.create(:user, :password => "mike")
    end

    before(:each) do
     visit '/login'
     fill_in 'user[email]', :with => user.email
     fill_in 'user[password]', :with => "mike"
     click_button("Sign In")
    end
    it "visits logout" do
      visit '/logout'
      visit '/login'
      page.should have_content("Login")
    end
  end
end