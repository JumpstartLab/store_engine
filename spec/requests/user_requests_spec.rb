require 'spec_helper'

describe "User" do
  let!(:user) do 
    FactoryGirl.create(:user, :password => "mike")
  end
  let!(:user2) do 
    FactoryGirl.create(:user)
  end
  context "Edit User" do 
    it "User needs to login before editing" do
      visit edit_user_path(user2)
      page.should have_content "Please login"
    end
    it "user can only edit themselves" do
      visit '/login'
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => "mike"
      click_button("Sign In")

      visit edit_user_path(user2)
      page.should have_content "You can only edit yourself"
    end
  end
end