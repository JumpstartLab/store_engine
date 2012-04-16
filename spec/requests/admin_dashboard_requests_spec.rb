require 'spec_helper'

describe "Products Requests" do
  context "when an admin is logged in" do
    let!(:user) { Fabricate(:user, :admin => true) }

    before(:each) { login }

    it "shows dashboard" do
      visit admin_dashboard_index_path
      page.current_path.should == admin_dashboard_index_path
    end
  end

  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user) }
    before(:each) { login }

    it "shows page not found" do
      validate_not_found(admin_dashboard_index_path)
    end
  end

  context "when a user is not logged in" do
    it "shows page not found" do
      validate_not_found(admin_dashboard_index_path)
    end
  end
end

