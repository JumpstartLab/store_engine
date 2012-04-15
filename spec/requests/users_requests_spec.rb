require 'spec_helper'

describe "Users requests" do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    before(:each)  { login }

    it "shows users page not found" do
      validate_not_found(users_path)
    end

    it "shows new user page not found" do
      validate_not_found(new_user_path)
    end

    it "shows create user page not found" do
      validate_not_found(users_path, "post")
    end
  end

  context "when not logged in" do
    it "shows page not found" do
      validate_not_found(users_path)
    end
  end

  context "when admin is logged in" do
  end
  
end
