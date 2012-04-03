require 'spec_helper'

describe User do
  describe ".find(id)" do
    it "returns the User with that id" do
      User.find(1).full_name.should == 'Matt Yoho'
    end
  end
end
