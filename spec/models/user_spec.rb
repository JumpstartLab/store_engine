require 'spec_helper'

describe User do
  let(:user) { Fabricate :user }

  it "can't be created with a blank name" do
    user.name = ""
    user.should_not be_valid
  end

  it "can't be created without an email address" do
    user.email = ""
    user.should_not be_valid
  end

  it "can't be created without a unique email address" do
    user
    meguser = User.new(:name => "Meg", 
      :email => "peter.griffin@livingsocial.com",
      :username => "unloved")
    meguser.should_not be_valid
  end

  it "can't be created with an invalid username" do
    user.username = "a"
    user.should_not be_valid
  end  
end
