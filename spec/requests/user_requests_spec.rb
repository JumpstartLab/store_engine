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
      login(user)
      visit edit_user_path(user2)
      page.should have_content "You can only edit yourself"
    end
    it "User can signup" do
      visit '/users/new'
      fill_in 'user[email]', :with =>  user.email
      fill_in "user[password]", :with => "mike"
      fill_in "user[name]", :with => user.name
      click_on "Sign up"
      page.should have_content("Products")
    end
  end
end