require 'spec_helper'

describe 'new user creates and edits account' do
  before(:each) do
    visit '/signup'
    fill_in "Full Name", with: 'Maya Angelou'
    fill_in "Email", with: 'poetry@poetry.com'
    fill_in "Display Name", with: 'poet'
    fill_in "Password", with: 'poet'
    fill_in "Password Confirmation", with: 'poet'
    click_button "Sign Up"
  end

  context 'when they provide unique login info' do
    it 'creates a new user account' do
      expect(page).to have_content "Welcome, Maya Angelou"
      expect(current_path).to eq root_path
    end

    it 'edits the account with valid input' do
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

  context 'when they provide non-unique login info' do
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
