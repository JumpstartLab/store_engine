require 'spec_helper'

describe "User" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user, :email => "test@test.com") }
  let!(:address) { FactoryGirl.create(:address, :user => user) }

  context "fails login" do
    it "fails login" do
      visit '/login'
      fill_in 'account_name', with: user.email
      click_button("Log In")
      page.should have_content("Email or password is invalid.")
    end
  end

  context "view a user" do
    it "requires login" do
      visit user_path(user)
      page.should have_content "You need to log in first"
    end

    context "while logged in" do
      it "shows the user page" do
        login(user)
        visit user_path(user)
        page.should have_content user.full_name
      end

      it "shows addresses associated with this user" do
        login(user)
        visit user_path(user)
        page.should have_content(address.city)
      end
    end
  end

  context "edit user" do
    it "requires login" do
      visit edit_user_path(user)
      page.should have_content "You need to log in first."
    end

    context "while logged in" do
      before(:each) { login(user) }
      it "displays the edit user page" do
        visit edit_user_path(user)
        page.should have_content(user.full_name)
        page.should have_content("Account Settings")
      end

      it "only for the current user" do
        visit edit_user_path(user2)
        page.should have_content "You can only edit yourself."
      end
    end
  end

  context "creating new users" do
    before(:each) { visit new_user_path }
    it "does not requires login" do
      page.should have_css('h1', :text => 'Sign Up')
    end

    it "creates a user given valid attributes" do
      fill_in "user[full_name]", :with => "Luke Skysauce"
      fill_in "user[email]", :with => "sky@walker.com"
      fill_in "user[password]", :with => "foobar"
      fill_in "user[password_confirmation]", :with => "foobar"
      click_on "Create User"
      page.should have_content "Thank you for signing up!"
    end
  end
end