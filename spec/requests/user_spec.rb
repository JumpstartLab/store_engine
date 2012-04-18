require 'spec_helper'
  describe 'User request' do
   it "allows a user to create an account" do
     visit new_user_path
     fill_in "Full name", with: "Test User"
     fill_in "Email Address", with: "supertestemail@foobar.com"
     fill_in "Password", with: 'asdfasdf'
     fill_in "Password confirmation", with: 'asdfasdf'
     click_button "Create User"
     page.should have_content "logout"
   end
 end
