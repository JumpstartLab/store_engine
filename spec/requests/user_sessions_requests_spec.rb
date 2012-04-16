require 'spec_helper'

describe "Users Sessions requests" do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    before(:each) { login }

    it "redirects to root" do
      visit '/login'
      page.current_path.should == root_path
    end
  end
end
