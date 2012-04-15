require 'spec_helper'

describe "AuthenticationPages" do

  describe "signin page" do
    before(:each) do
      visit signin_path
    end

    it "should have signin page headers and title" do
      page.should have_selector('h1', text: 'Sign in')
      page.should have_selector('title', text: 'Sign in')
    end

    describe "signin" do
      before(:each) do
        visit signin_path
      end

      context "with invalid information" do
        before(:each) do
          click_link_or_button "Sign in"
        end

        it "should have signin page headers and title" do
          pending
          page.should have_selector('h1', text: 'Sign in')
          page.should have_selector(".alert alert-error", text: 'Invalid email/password combination')
        end
      end

      context "after visiting another page" do
        before { click_link_or_button "Sign up now!" }

        it "should not have any login failer alert message" do
          page.should_not have_selector('div.alert.alert-error')
        end
      end

      context "with valid information" do
        let!(:user) { Fabricate(:user) }
        before do
          fill_in "Email",        with: user.email
          fill_in "Password",     with: user.password
          click_link_or_button "Sign in"
        end

        it "should have the user's name set as the title of the page" do
          page.should have_selector('title', text: user.name)
        end

        it "should have a link to the user's profile page" do
          page.should have_link('Profile', href: user_path(user))
        end

        it "should have a sign-out link" do
          page.should have_link('Sign out', href: signout_path)
        end

        it "should not have a sign-in link" do
          page.should_not have_link('Sign in', href: signin_path)
        end
      end
    end
  end
end
