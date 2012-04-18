require 'spec_helper'

describe "Logging in a User" do
  context "when logging in a user" do

    before(:each) do
      @user = Fabricate(:user, :password => 'password')
      visit "/login"
    end

    it "logs in a user" do
      within("div#thinForm") do
        fill_in 'email', :with => @user.email
        fill_in 'password', :with => 'password'
        click_button 'Log in'
      end
      current_path.should == "/"
    end

    it "redirects and shows an error for invalid user credentials" do
      within("div#thinForm") do
        fill_in 'email', :with => "poop"
        fill_in 'password', :with => 'poopface'
        click_button 'Log in'
      end
      current_path.should == sessions_path
      page.should have_content("Invalid login/password.")
    end

  end
end