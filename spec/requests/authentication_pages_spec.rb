require 'spec_helper'

describe "AuthenticationPages" do

  describe "signin" do

    before(:each) { visit signin_path }

    describe "with invalid information" do

      it "displays an error message" do
        click_button('Sign in')
        page.should have_selector('div.alert.alert-error', :text => "Invalid")
      end

      describe "after visiting another page" do
        it "should not persist the error message" do
          click_link('logo')
          should_not have_selector('div.alert.alert-error')
        end
      end
    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "session_email",    with: user.email
        fill_in "session_password", with: user.password
        click_button "Sign in"
      end

      describe "followed by signout" do
        it "user should sign out" do
          click_link('Sign out')
          page.should have_link('Sign in')
        end
      end
    end

  end

end