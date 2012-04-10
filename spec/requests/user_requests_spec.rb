require 'spec_helper'

describe "User Requests" do
  let!(:user) { Fabricate(:user) }
  describe "index" do
    before(:each) do
      visit "/"
      click_link "Sign-In"
      fill_in "Email", :with => user.email_address
      fill_in "Password", :with => user.password
      click_link_or_button "sign_in_button"
    end
    it "can see users" do
      visit users_path
      page.should have_selector("#users")
    end
  end

  describe "new" do
    before(:each) do
      @size = User.all.size
      visit "/"
      click_link "Sign-Up"
    end
    it "can create a new user" do
      fill_in "Full name", with: "Test"
      fill_in "Email address", with: "test@test.com"
      fill_in "Password", with: "test"
      fill_in "Password confirmation", with: "test"
      click_link_or_button "Create User"
      current_path.should == "/"
      User.all.size.should == @size + 1
    end
    it "does not create a user with invalid attributes" do
      click_link_or_button "Create User"
      User.all.size.should == @size
    end
  end

  describe "destroy" do
    it "destroys a record", js: true do
      pending
      dead_user = Fabricate(:user)
      visit "/"
      click_link "Sign-In"
      fill_in "Email", :with => user.email_address
      fill_in "Password", :with => user.password
      click_link_or_button "sign_in_button"
      visit user_path(dead_user)
      puts "Gets to dead user page"
      click_link_or_button "Destroy"
      page.driver.browser.switch_to.alert.accept
      User.all.size.should == 1
    end
  end

  describe "update" do
    it "updates the attributes of a user" do
      visit "/"
      click_link "Sign-In"
      fill_in "Email", :with => user.email_address
      fill_in "Password", :with => user.password
      click_link_or_button "sign_in_button"
      visit user_path(user)
      within ".main-content" do

        click_link_or_button "Edit"
      end
      fill_in "Display name", :with => "Happy Bear"
      click_link_or_button "Update User"
      current_path.should == user_path(user)
      updated_user = User.find(user.id)
      updated_user.display_name.should == "Happy Bear"
    end
  end
end