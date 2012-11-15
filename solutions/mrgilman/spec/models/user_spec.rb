require 'spec_helper'

describe User do
  context "validations" do
    it "saves only unique email addresses" do
      Fabricate(:user, :email => "foo@foo.com")
      lambda { Fabricate(:user, :email => "foo@foo.com") }.should raise_error
    end

    it "has a first name" do
      lambda { Fabricate(:user, :first_name => "") }.should raise_error
    end

    it "has a last name" do
      lambda { Fabricate(:user, :last_name => "") }.should raise_error
    end

    it "has optional display name" do
      lambda { Fabricate(:user, :display_name => "") }.should_not raise_error
    end

    it "has display name greater than 1 characters" do
      lambda { Fabricate(:user, :display_name => "a") }.should raise_error
    end

    it "has display name less than 33 characters" do
      name = ""
      33.times { |i| name += "a" }
      lambda { Fabricate(:user, :display_name => name) }.should raise_error
    end
  end
end
