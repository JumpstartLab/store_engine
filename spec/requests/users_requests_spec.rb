require 'spec_helper'

describe "Users requests" do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    before(:each)  { login }

    it "shows users page not found" do
      validate_not_found(users_path)
    end

    it "shows new user page not found" do
      validate_not_found(new_user_path)
    end

    it "shows create user page not found" do
      validate_not_found(users_path, "post")
    end

    it "logs a user out" do
      visit products_path
      find_link("Logout").click
      page.current_path.should == root_path
      page.should have_content("Logged out")
    end
  end

  context "when not logged in" do
    it "shows user page not found" do
      validate_not_found(users_path)
    end

    it "shows new user page not found" do
      validate_not_found(new_user_path)
    end

    it "shows create user page not found" do
      validate_not_found(users_path, "post")
    end
  end

  context "when admin is logged in" do
    let!(:user) { Fabricate(:user, :admin => true)}
    before(:each)  { login }

    it "shows users" do
      visit users_path
      page.current_path.should == users_path
    end

    it "creates a new user" do
      visit users_path
      find_link("New User").click

      fill_in "Username", :with => "newuser"
      fill_in "Display name", :with => "displayname"
      fill_in "First name", :with => "firstname"
      fill_in "Last name", :with => "lastname"
      fill_in "Email", :with => "email@email.com"
      fill_in "Password", :with => "cheeet"
      fill_in "Password confirmation", :with => "cheeet"
      click_button("Create User")
      page.current_path.should == root_path
      page.should have_content("Registration successful")
    end
  end
end
