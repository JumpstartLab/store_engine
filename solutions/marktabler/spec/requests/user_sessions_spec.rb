require 'spec_helper'
  describe 'UserSession request' do
    it "allows a user to provide credentials" do
      visit login_path
      fill_in 'Email', with: 'a@b.com'
      fill_in 'Password', with: 'asdfasdf'
      click_button "Sign In"
    end

    it "signs in a user if the credentials are good" do
      @user = Fabricate(:user)
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'asdfasdf'
      click_button "Sign In"
      page.should have_content @user.email
      page.should have_content "logout"
    end

    it "displays an error if the credentials are bad" do
      visit login_path
      fill_in 'Email', with: 'bad@example.com'
      fill_in 'Password', with: 'asdfasdf'
      click_button "Sign In"
      page.should have_content "invalid"
    end

    it "allows a user to sign out" do
      @user = Fabricate(:user)
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'asdfasdf'
      click_button "Sign In"
      click_link "logout"
      page.should have_content "login"
      page.should_not have_content @user.email
    end
  end
