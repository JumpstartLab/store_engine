require 'spec_helper'

describe "Users requests" do
  context "when a user is logged in" do
  end

  context "when not logged in" do
    it "shows page not found" do
      validate_not_found(users_path)
    end
  end

  context "when admin is logged in" do
  end
  
end
