require 'spec_helper'

describe "User" do
  let!(:user) do 
    FactoryGirl.create(:admin, :password => "mike")
  end
  let!(:user2) do 
    FactoryGirl.create(:user)
  end
  context "Failed Login" do
    it "Fails Login" do
      visit '/login'
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => "jiberish"
      click_button("Sign In")
      page.should have_content("incorrect username or password")
    end
  end
  context "Edit User" do 
    it "needs to login before editing" do
      visit edit_user_path(user2)
      page.should have_content "Please login"
    end
    context "After login" do
      before(:each) do
        login(user)
      end
      it "can only edit themselves" do
        visit edit_user_path(user2)
        page.should have_content "You can only edit yourself"
      end
      it "can edit themselves" do
        visit edit_user_path(user)
        page.should have_content(user.name)
      end
      it "can update themselves" do
        visit edit_user_path(user)
        fill_in 'user[name]', :with => "rabble"
        click_on "Edit User"
        page.should have_content("rabble")
      end
      it "has validation on update" do 
        visit edit_user_path(user)
        fill_in 'user[name]', :with => ""
        click_on "Edit User"
        page.should have_content("Edit User")        
      end
    end
    it "User can signup" do
      visit '/users/new'
      fill_in 'user[email]', :with =>  "Jiberish@yahoo.com"
      fill_in "user[password]", :with => "mike"
      fill_in "user[name]", :with => "Wooo"
      click_on "Sign up"
      page.should have_content("Products")
    end
    it "User verifies auth" do
      visit '/users/new'
      fill_in 'user[email]', :with =>  ""
      fill_in "user[password]", :with => ""
      fill_in "user[name]", :with => ""
      click_on "Sign up"     
      page.should have_content("can't be blank") 
    end
  end
  context "Visit User" do
    it "lists all the users" do
      login(user)
      visit '/users/'
      page.should have_content user.name
    end
  end
  context "User can be destroyed" do
    it "removes user" do
      login(user)
      visit users_path
      within("#user_#{user2.id}") do
        click_on "delete"
      end
      #save_and_open_page
      page.should_not have_content(user2.email)
    end
  end
end