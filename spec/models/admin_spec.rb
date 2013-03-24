require File.dirname(__FILE__) + '/../spec_helper'

describe Admin do
  let(:admin) { Admin.new(email: "blah@blah.com") }

  it "should be valid" do
    expect(admin).to be_valid
  end

  it "should not be valid without an email" do
    admin.email = nil
    expect(admin).to_not be_valid
  end
end
