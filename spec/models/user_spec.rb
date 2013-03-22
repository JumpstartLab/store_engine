require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
    @user = User.new(email: "blah@blah.com", full_name: "hihi")
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should not be valid without an email" do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it "should not be valid a duplicate email" do
    @user.save
    user = User.new(email: "blah@blah.com", full_name: "herro")
    expect(user.valid?).to be_false
  end

  it "should not be valid without a full name" do
    @user.full_name = ""
    expect(@user).to_not be_valid
  end

  it "should not be valid if display name is not between 2-32 chars if it exists" do
    @user.display_name = "p"
    expect(@user).to_not be_valid
    @user.display_name = "p" * 33
    expect(@user).to_not be_valid
    @user.display_name = "p" * 32
    expect(@user).to be_valid
  end
end
