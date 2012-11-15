require 'spec_helper'

describe User do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }

  describe "Users" do
    context "non-authenticated user" do
      describe "GET /user" do
        email_faker = "#{Faker::Name.first_name}@#{Faker::Name.last_name}.com"
        it "lets an unauthorized user create an account" do
          visit new_user_path
          fill_in "Email", with: email_faker
          fill_in "Password", with: "123456"
          fill_in "Password confirmation", with: "123456"
          fill_in "Full name", with: "testing me"
          fill_in "User name", with: "lovetest123"
          click_button "Create User"
          page.should have_content("Please login to continue")
        end

        # it "can log in with that user" do
        #   visit login_path
        #   save_and_open_page
        #   fill_in "Email", with: email_faker
        #   fill_in "Password", with: "123456"
        #   click_button "Log in"
        #   page.should have_content(email_faker)
        # end
      end
    end

    context "user is logged in as an admin" do
      before(:each) do
        visit login_path
        fill_in "email", with: admin_user.email
        fill_in "password", with: "123"
        click_button "Log in"
      end

      it "enables an admin to view alll users" do
        visit users_path
        User.all.each do |user|
          page.should have_content(user.email)
        end
      end

      it "allows a user to logout" do
        click_on "Log Out"
        page.should have_content("Logged out!")
      end

    end
  end
end
