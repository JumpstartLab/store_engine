require 'spec_helper'

describe User do
  it "has a valid factory" do
    Factory.create(:user).should be_valid
  end

  it "is invalid without a full_name" do
    Factory.build(:user, full_name: nil).should_not be_valid
  end

  it "is invalid without a password" do
    Factory.build(:user, password: nil).should_not be_valid
  end

  it "is invalid without an email" do
    Factory.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without a unique email" do
    Factory.create(:user)
    Factory.build(:user).should_not be_valid
  end

  it "is invalid if the username is under 2 characters" do
    Factory.build(:user, user_name: "a").should_not be_valid
  end

  it "is invalid if the username is over 32 characters" do
    Factory.build(:user, user_name: "#{Array.new(33) { (rand(122-97) + 97).chr }.join}").should_not be_valid
  end
end
