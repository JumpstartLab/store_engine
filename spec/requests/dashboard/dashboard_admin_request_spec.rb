require 'spec_helper'

describe "Dashboard" do
  let(:admin)    { Fabricate(:user, :admin => true)}
  let(:user)     { Fabricate(:user) }
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:product)  { Fabricate(:product) }

  let(:pending_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }


  let(:paid_order)       { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let(:cancelled_order)  { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let(:shipped_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let(:returned_order)   { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let(:orders) {{"pending"   => pending_order, 
                 "paid"      => paid_order,
                 "cancelled" => cancelled_order,
                 "shipped"   => shipped_order,
                 "returned"  => returned_order }}

  statuses = ["pending", "paid", "cancelled", "returned", "shipped"]


  before(:each) do
    login(admin)
    orders.values.each {|order| order.save}
    pending_order.order_statuses.new(  :status => "pending")
    paid_order.order_statuses.new(     :status => "paid")
    cancelled_order.order_statuses.new(:status => "cancelled")
    shipped_order.order_statuses.new(  :status => "shipped")
    returned_order.order_statuses.new( :status => "returned")

    orders.values.each {|order| order.save }
  end



  it "shows the statuses for the orders" do
    visit "admin/dashboard"
    orders.values.each do |order|
      within("#order_#{order.id}") do
        page.should have_content(order.status)
      end
    end
  end

  it "shows the date the order was created" do
    visit "admin/dashboard"
    orders.values.each do |order|
      within("#order_#{order.id}") do
        page.should have_content(order.created_at)
      end
    end
  end

  it "filters the orders by status" do
  visit "admin/dashboard"
  statuses.each do |status|
    visit "dashboard"
    test_order = orders[status.to_s]
    click_link_or_button "#{status.capitalize} Orders"
      page.should have_content(test_order.id)
    end
  end

  it "contains a link to all orders" do
    visit "admin/dashboard"
    click_link_or_button "All Orders"
  end

  context "when changing an order status" do
    before(:each) { visit "admin/dashboard" }

    it "has a button to upgrade order status" do
      page.should have_link("Mark Paid")
      page.should have_link("Mark Shipped")
      page.should have_link("Mark Pending")
      page.should have_link("Mark Returned")
      page.should have_link("Mark Cancelled")
    end

    it "changes the order status" do
      within("tr#order_#{pending_order.id}") do
        click_link_or_button("Mark Paid")
      end
      within("tr#order_#{pending_order.id}") do
        page.should have_content("paid")
      end
    end
  end
end









