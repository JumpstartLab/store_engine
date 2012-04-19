require 'spec_helper'
  describe 'Admin Order' do
    it "allows an admin to view an order" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      visit admin_order_path(@order)
    end

    it "allows an admin to ship a pending order" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      visit admin_order_path(@order)
      click_link "Ship"
      visit admin_order_path(@order)
      page.should_not have_content("pending")
      page.should have_content("shipped")
    end


    it "allows an admin to cancel a pending order" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      visit admin_order_path(@order)
      click_link "Cancel"
      visit admin_order_path(@order)
      page.should_not have_content("pending")
      page.should have_content("cancelled")
    end

    it "allows an admin to return a shipped order" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      @order.update_attribute(:status, 'shipped')
      visit admin_order_path(@order)
      click_link "Return"
      visit admin_order_path(@order)
      page.should_not have_content("shipped")
      page.should have_content("returned")
    end


    it "allows an admin to edit an order item's quantity" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      visit edit_admin_order_path(@order)
      fill_in "order_item_quantities", with: 4
      click_button "Update Order"
      visit admin_order_path(@order)
      page.should have_content(@order.order_items.first.product.price * 4)
    end

    it "allows an admin to filter orders by status" do
      u = Fabricate(:user)
      u.update_attribute(:admin, true)
      log_in(u, 'asdfasdf')
      @order = Fabricate(:order)
      visit admin_orders_path(@order, status_filter: 'pending', commit: "Filter")
      page.should have_content @order.email_address
      visit admin_orders_path(@order, status_filter: 'returned', commit: "Filter")
      page.should_not have_content @order.email_address
    end
  end

