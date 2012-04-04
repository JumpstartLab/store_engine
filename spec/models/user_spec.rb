require 'spec_helper'

describe User do

  [:email_address, :full_name, :display_name].each do |attr|
    it "has an attribute #{attr}" do
      User.new.should respond_to(attr)
    end
  end

  context "valid attributes" do
    let(:user) { Fabricate(:user) }

    context "presence of" do
      it "is valid with valid attributes" do
        user.should be_valid
      end

      it "is not valid without a email_address" do
        user.email_address = nil
        user.should_not be_valid
      end

      it "is not valid without a full_name" do
        user.full_name = nil
        user.should_not be_valid
      end

      it "is valid without a display_name" do
        user.display_name = nil
        user.should be_valid
      end
    end

    context "type validations" do
      it "does not allow a duplicate email_address to be created" do
        user_1 = {email_address: "a@a.com", full_name: "b"}
        user_2 = {email_address: "a@a.com", full_name: "c"}
        User.create(user_1)
        User.create(user_2).should_not be_valid
      end

      it "does not accept an invalid email address" do
        user.email_address = "blah"
        user.should_not be_valid
      end

      it "does not accept a display name that is too short or too long" do
        user.display_name = "a"
        user.should_not be_valid

        user.display_name = "asdijvba;iowejb;oiajrb;oiweaje;biajwe;bijawe"
        user.should_not be_valid
      end

    end
  end
end