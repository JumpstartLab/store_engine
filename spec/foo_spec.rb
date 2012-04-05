$:.unshift("lib")
require 'foo'

describe "foo" do
  it "returns true" do
    foo.should be_true
  end
end
