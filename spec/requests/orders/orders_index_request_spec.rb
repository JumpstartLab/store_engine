require 'spec_helper'

describe "Orders" do
  let(:admin)    { Fabricate(:user, :admin => true, 
                             :password => "password")}
  let(:user)     { Fabricate(:user, :password => "password") }
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:product)  { Fabricate(:product) }

  let!(:pending_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }


  let!(:paid_order)       { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let!(:cancelled_order)  { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let!(:shipped_order)    { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let!(:returned_order)   { Order.create(:user_id => user.id, 
                             :billing_address_id => billing.id,
                             :shipping_address_id => shipping.id ) }

  let!(:orders) {{"pending"   => pending_order, 
                 "paid"      => paid_order,
                 "cancelled" => cancelled_order,
                 "shipped"   => shipped_order,
                 "returned"  => returned_order }}


  context "when visiting the index" do
    it "shows the user a list of their orders" do
      login(user)
      visit "/orders"
      orders.each do |key, order|
        page.should have_content(order.id)
      end
    end
  end
end