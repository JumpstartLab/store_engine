require 'spec_helper'

describe UserSessionsController do

  describe "GET 'login'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "allows a user to provide credentials" do
      visit login_path
      save_and_open_page
      fill_in 'Email', with: 'a@b.com'
      fill_in 'Password', with: 'asdfasdf'
      click "Log in"
    end

    it "signs in a user if the credentials are good" do

    end

    it "displays an error if the credentials are bad" do

    end
  end

end
