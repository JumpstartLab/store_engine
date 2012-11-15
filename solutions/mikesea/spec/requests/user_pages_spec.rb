require 'spec_helper'

describe "User pages" do

  describe "signup page" do
    before { visit signup_path }

    # it { should have_field('user_email', :type => 'text') }

    describe "when I click create my account" do
      describe "when the form is empty" do
        it "does not register a user" do
          expect { click_button "Create Account" }.not_to change(User, :count)
        end
      end

      describe "when I have valid user details" do
        before do
          fill_in "user_name",         with: "Example User"
          fill_in "user_email",        with: "user@example.com"
          fill_in "user_password",     with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button "Create Account" }.to change(User, :count).by(1)
        end
      end

    end
  end



end