require 'spec_helper'

describe "AuthenticationPages" do

  describe "signin" do

    before(:each) { visit signin_path }

    describe "with invalid information" do

      it "displays an error message" do
        click_link_or_button('Log in')
        page.should have_selector('div.alert.alert-alert', :text => 'Email or password was invalid.')
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
      attrs = FactoryGirl.attributes_for(:user)

      before do
        fill_in "email",    with: user.email
        fill_in "password", with: attrs[:password]
        click_button "Log in"
      end

      describe "followed by signout" do
        it "user should sign out" do
          click_link_or_button('Sign out')
          page.should have_link('Sign in')
        end
      end
    end

  end

end