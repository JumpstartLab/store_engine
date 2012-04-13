require 'spec_helper'

describe User do
  context "valid attributes" do
    let(:user) { FactoryGirl.build(:user) }

    it "is valid with valid attributes" do
      user.should be_valid
    end

    it "is valid without a display name" do
      user.display_name = nil
      user.should be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      user.should_not be_valid
    end

    it "is not valid if password is less than length 6" do
      user.password = "abc12"
      user.should_not be_valid
    end

    it "is not valid without an e-mail" do
      user.email = nil
      user.should_not be_valid
    end
  end
end
