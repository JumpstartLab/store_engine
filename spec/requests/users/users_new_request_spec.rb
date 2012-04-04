require 'spec_helper'

describe "Create New User" do
  context "when creating new user" do
    before(:each) do
      visit "/signup"
    end

    it "creates a new user via the form" do
      within("#thinForm") do
        fill_in 'user_first_name', :with => 'Worace'
        fill_in 'user_last_name', :with => 'Hilliams'
        fill_in 'user_email', :with => 'user@example.com'
        fill_in 'user_password', :with => 'password'
        fill_in 'user_password_confirmation', :with => 'password'
      end
      click_button 'Sign up'
      current_path.should == "/"
    end

  end
  
end