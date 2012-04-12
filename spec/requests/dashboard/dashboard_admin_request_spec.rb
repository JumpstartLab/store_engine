require 'spec_helper'

describe "Dashboard" do
  let(:admin)    { Fabricate(:user, :admin => true)}
  let(:user)     { Fabricate(:user) }
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:product)  { Fabricate(:product) }

  let(:pending_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id,
                             :status => "pending" ) }


  let(:paid_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id,
                             :status => "paid" ) }

  let(:cancelled_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id,
                             :status => "cancelled" ) }

  let(:shipped_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id,
                             :status => "shipped" ) }

  let(:returned_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id,
                             :status => "returned" ) }

  let(:orders) {[pending_order, paid_order,
                 cancelled_order, shipped_order, 
                 returned_order]}

  statuses = ["pending", "paid", "cancelled", "returned", "shipped"]


  before(:each) do
    login(admin)
    orders.each {|order| order.save}
  end


  it "shows the statuses for the orders" do
    visit "admin/dashboard"
    orders.each do |order|
      within("#order_#{order.id}") do
        page.should have_content(order.status)
      end
    end
  end

  it "shows the date the order was created" do
    visit "admin/dashboard"
    orders.each do |order|
      within("#order_#{order.id}") do
        page.should have_content(order.created_at)
      end
    end
  end
end