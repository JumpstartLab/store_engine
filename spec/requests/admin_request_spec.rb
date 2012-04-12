require 'spec_helper'
  describe 'Admin Request' do
    it "disallows a guest user" do
      visit admin_orders_path
      URI.parse(current_url).path.should == login_path
    end

    it "disallows a non-admin user" do
      u = Fabricate(:user)
      log_in(u, 'asdfasdf')
      visit admin_orders_path
      URI.parse(current_url).path.should == login_path
    end

    it "allows an admin user" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      visit admin_orders_path
      URI.parse(current_url).path.should == admin_orders_path
    end
  end
