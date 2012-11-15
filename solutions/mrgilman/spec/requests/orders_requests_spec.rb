require 'spec_helper'

describe "Orders requests", :orders => :requests do
  context "when a normal user is logged in" do
    let!(:user) { Fabricate(:user)}
    let!(:user2) { Fabricate(:user, :email => "omg@omg.com",
                             :password => "woah")}
    let!(:order) { Fabricate(:order, :user => user) }
    let!(:order2) { Fabricate(:order, :user => user2) }

    before(:each)  do
      login_user_post("omg@omg.com", "woah") 
      visit orders_path
    end 

    it "shows current users orders" do
      page.should have_content("#{order2.created_display_date}")
    end

    it "shows individual order page" do
      click_link "#{order.created_display_date}"
      page.current_path.should == order_path(order2.id)
    end

    it "shows update page not found" do
      validate_not_found(order_path(order), "put")
    end
  end

  context "when a user is not logged in" do
    let!(:user) { Fabricate(:user)}
    let!(:order) { Fabricate(:order, :user => user) }
    it "shows page not found" do
      validate_not_found(orders_path)
    end

    it "shows update page not found" do
      validate_not_found(order_path(order), "put")
    end
  end

  context "when an admin is logged in" do
    let!(:user) { Fabricate(:user, :admin => true) }
      let!(:pending_status) { Fabricate(:status) }
      let!(:shipped_status) { Fabricate(:status, 
                                     :name => StoreEngine::Status::SHIPPED) } 
      let!(:paid_status) { Fabricate(:status, 
                                     :name => StoreEngine::Status::PAID) } 
      let!(:cancelled_status) { Fabricate(:status, 
                                     :name => StoreEngine::Status::CANCELLED) } 
      let!(:returned_status) { Fabricate(:status, 
                                     :name => StoreEngine::Status::RETURNED) } 

    context "and viewing pending orders" do
      let!(:order) { Fabricate(:order, :user => user, 
                               :status => pending_status ) }

      before(:each)  do
        login
        visit admin_dashboard_index_path
        click_button "Cancel"
      end 

      it "cancels a pending order" do
        page.should_not have_content(order.created_display_date) 
      end

      it "displays a pending order as cancelled" do
        visit admin_dashboard_index_path(:status => cancelled_status.name)
        page.should have_content(order.created_display_date) 
      end
    end

    context "and viewing shipped orders" do
      let!(:order) { Fabricate(:order, :user => user, 
                               :status => shipped_status ) }

      before(:each)  do
        login
        visit admin_dashboard_index_path(:status  => shipped_status.name)
        click_button "return_order"
      end 

      it "changes order status to returned" do
        visit admin_dashboard_index_path(:status  => returned_status.name)
        page.should have_content(order.created_display_date) 
      end

      it "marks order as returned" do
        page.should_not have_content(order.created_display_date) 
      end
    end

    context "and viewing paid orders" do
      let!(:order) { Fabricate(:order, :user => user, 
                               :status => paid_status ) }

      before(:each)  do
        login
        visit admin_dashboard_index_path(:status  => paid_status.name)
        click_button "shipped_order"
      end 

      it "changes order status to shipped" do
        visit admin_dashboard_index_path(:status  => shipped_status.name)
        page.should have_content(order.created_display_date) 
      end

      it "marks order as shipped" do
        page.should_not have_content(order.created_display_date) 
      end
    end
  end
end

