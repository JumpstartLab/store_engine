require 'spec_helper'

describe "User pages" do

  describe "signup page" do
    before(:each) do
      visit signup_path
    end

    it "should have signup page headers and title" do
      page.should have_selector('h1', text: 'Sign up')
      page.should have_selector('title', text: 'Sign up')
    end

    context "with invalid signup information" do
      it "should not create a new user" do
        expect { click_link_or_button "Create my account" }.not_to change(User, :count)
      end
    end

    context "with valid signup information" do

      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "foobarbaz@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a new user" do
        expect { click_link_or_button "Create my account" }.to change(User, :count).by(1)
      end

      context "after saving the user" do
        before(:each) do
          click_link_or_button submit
        end

        let(:user) { User.find_by_email('user@example.com') }

        it "should have a title including the user's name" do
          page.should have_selector('title', text: user.name)
        end

        it "should have the welcome alert message" do
          page.should have_selector('div.alert.alert-success', text: 'Welcome')
        end

        it "should have sign out link" do
          page.should have_link('Sign out')
        end
      end

      context "followed by signout" do
        before(:each) do
          click_link_or_button "Sign out"
        end

        it "should have a sign in link" do
          page.should have_link('Sign in')
        end
      end
    end
  end

  describe "profile page" do
    let!(:user) { Fabricate(:user) }
    before(:each) do
      visit user_path(user)
    end

    it "should have the user name for the header and page title" do
      page.should have_selector('h1', text: user.name)
      page.should have_selector('title', text: user.name)
    end
  end
end