require 'spec_helper'

describe "Users requests" do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    let!(:user2) { Fabricate(:user, :email => "omg@omg.com",
                             :password => "woah")}
    before(:each)  { login }

    it "shows users page not found" do
      validate_not_found(users_path)
    end

    it "shows new user page not found" do
      visit new_user_path
      page.current_path.should == root_path
    end

    it "shows user page" do
      visit user_path(user)
      page.current_path.should == user_path(user)
    end

    context "when visiting the edit page" do
      before(:each) { visit edit_user_path(user) }

      it "shows edit page for user" do
        page.current_path.should == edit_user_path(user)
      end

      it "does not show admin option" do
        page.should_not have_content("Admin")
      end

      it "shows edit page not found for another user" do
        validate_not_found(edit_user_path(user2))
      end
    end

    it "shows page not found for another user" do
      validate_not_found(user_path(user2))
    end

    it "logs a user out" do
      visit products_path
      find_link("Logout").click
      page.current_path.should == root_path
      page.should have_content("Logged out")
    end
  end

  context "when not logged in" do
    let!(:user) { Fabricate(:user)}

    it "shows user page not found" do
      validate_not_found(users_path)
    end

    it "shows page not found" do 
      validate_not_found(user_path(user))
    end

    it "shows page not found" do 
      validate_not_found(edit_user_path(user))
    end

    it "shows create user page not found" do
      validate_not_found(user_path(user), "put")
    end

    context "when visiting new user page" do
      before(:each) { visit new_user_path  }

      it "shows new user page" do
        page.current_path.should == new_user_path
      end

      it "does not show admin link" do
        page.should_not have_content("Admin")
      end
    end
  end

  context "when admin is logged in" do
    let!(:user) { Fabricate(:user, :admin => true)}
    let!(:user2) { Fabricate(:user, :email => "omg@omg.com",
                             :password => "woah")}
    before(:each)  { login }

    it "shows users" do
      visit users_path
      page.current_path.should == users_path
    end

    it "creates a new user" do
      visit users_path
      find_link("New User").click

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

    it "creates a admin new user" do
      visit users_path
      find_link("New User").click

      fill_in "Display name", :with => "displayname"
      fill_in "First name", :with => "firstname"
      fill_in "Last name", :with => "lastname"
      fill_in "Email", :with => "email@email.com"
      fill_in "Password", :with => "cheeet"
      fill_in "Password confirmation", :with => "cheeet"
      check "Admin"
      click_button("Create User")

      visit logout_path
      login_user_post("email@email.com", "cheeet")
      visit root_path
      page.should have_content("Admin Dashboard")
    end

    it "shows page not found when editing another user page" do
      validate_not_found(edit_user_path(user2))
    end

    it "shows any user" do
      visit user_path(user)
      page.current_path.should == user_path(user)
      visit user_path(user2)
      page.current_path.should == user_path(user2)
    end
  end
end
