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

  end
end