require 'spec_helper'

describe "In the admin dashboard" do

  describe "a visitor who is not logged in" do

    it "cannot access the admin dashboard" do
      visit "/admin/dashboard"
      page.should_not have_content("Admin Dashboard")
    end

  end

  describe "a standard user" do
    let!(:user) { Fabricate(:user) }

    before(:each) do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    it "cannot access the admin dashboard" do
      visit "/admin/dashboard"
      page.should_not have_content("Admin Dashboard")
    end

  end

  describe "an admin user" do

    let!(:user) { Fabricate(:user, admin: true) }

    before(:each) do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    it "can access the admin dashboard" do
      visit "/admin/dashboard"
      page.should have_content("Admin Dashboard")
    end

  end

end