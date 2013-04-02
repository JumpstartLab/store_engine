require 'spec_helper'

describe 'new user creates and edits account' do
  def signup_user
    visit '/signup'
    fill_in "Full Name", with: 'Maya Angelou'
    fill_in "Email", with: 'poetry@poetry.com'
    fill_in "Display Name", with: 'poet'
    fill_in "Password", with: 'poet'
    fill_in "Password Confirmation", with: 'poet'
    click_button "Sign Up"
  end

  describe 'registering a new account' do
    before(:each) do
      signup_user
    end

    context 'when they provide unique login info' do
      it 'creates a new user account' do
        expect(page).to have_content "Welcome, Maya Angelou"
        expect(current_path).to eq root_path
      end
    end

    context 'when they provide non-unique login info for registration' do
      it 'returns an error message' do
        visit '/signup'
        fill_in "Full Name", with: 'NOT MAYA'
        fill_in "Email", with: 'poetry@poetry.com'
        fill_in "Display Name", with: 'poet'
        fill_in "Password", with: 'poet'
        fill_in "Password Confirmation", with: 'poet'
        click_button "Sign Up"
        expect(page).to have_content "has already been taken"
        expect(current_path).to eq '/users'
      end
    end

  end

  describe 'signing in and out of account' do
    before(:each) do
      signup_user
    end

    it 'allows them to log out of their account' do
      visit login_path
      fill_in "Email", with: 'poetry@poetry.com'
      fill_in "Password", with: "poet"
      click_button "Login"
      expect(current_path).to eq login_path
      click_link_or_button "Logout"
      expect(current_path).to eq root_path
      expect(page).to have_content "Logged out!"
    end

    it 'rejects incorrect login info on signin' do
      visit login_path
      fill_in "Email", with: 'poetry@poetry.com'
      fill_in "Password", with: "whatsmypassword"
      click_button "Login"
      expect(current_path).to eq login_path
      expect(page).to have_content 'invalid'
    end
  end

  it 'edits the account with valid input' do
    signup_user
    visit login_path
    fill_in "Email", with: 'poetry@poetry.com'
    fill_in "Password", with: "poet"
    click_button "Login"
    visit account_profile_path
    fill_in "Display Name", with: 'Maya'
    click_button "Update Account"
    expect(current_path).to eq account_profile_path
    expect(page).to have_content "updated account"
  end
end
