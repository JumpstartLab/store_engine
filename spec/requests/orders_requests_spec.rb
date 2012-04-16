require 'spec_helper'

describe "Orders requests" do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    let!(:user2) { Fabricate(:user, :email => "omg@omg.com",
                             :username => "woah", :password => "woah")}
    let!(:order) { Fabricate(:order, :user => user) }
    let!(:order2) { Fabricate(:order, :user => user2) }

    before(:each)  do
      login_user_post("woah", "woah") 
      visit orders_path
    end 

    it "shows current users orders" do
      page.should have_content("#{order2.updated_at}")
    end

    it "shows individual order page" do
      click_link "#{order.updated_at}"
      page.current_path.should == order_path(order2.id)
    end
  end

  context "when a user is not logged in" do
    it "shows page not found" do
      validate_not_found(orders_path)
    end
  end
end
