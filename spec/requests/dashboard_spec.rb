require 'spec_helper'

describe "Dashboard" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, :admin => true) }
  
  describe "admin access" do
    it "requires admin login" do
      visit "/dashboard"
      page.should have_content "Not an admin"
    end
  end

  describe "GET /dashboard" do
    it "requires admin for logged in users" do
      login(user)
      visit "/dashboard"
      page.should have_content "Not an admin"
    end

    it "successfully logs in an admin" do
      login(admin)
      visit "/dashboard"
      page.should have_content "Dashboard"
    end
  end

  describe "while admin is logged in" do

  end
end