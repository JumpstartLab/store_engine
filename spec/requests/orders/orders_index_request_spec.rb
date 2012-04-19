require 'spec_helper'

describe "Orders" do
  let(:admin)             { Fabricate(:user, :admin => true,
                                      :password => "password")}
  let(:user)              { Fabricate(:user, :password => "password") }
  let(:billing)           { Fabricate(:address) }
  let(:shipping)          { Fabricate(:address) }

  let(:user2)             { Fabricate(:user, :password => "testing")}
  let(:billing2)          { Fabricate(:address) }
  let(:shipping2)         { Fabricate(:address) }

  let!(:other_user_order) { Order.create(:user_id => user2.id,
                             :billing_address_id => billing2.id,
                             :shipping_address_id => shipping2.id ) }

  let!(:product)          { Fabricate(:product) }
  let(:order_product)     { OrderProduct.create(:quantity => 1,
                             :product_id => product.id,
                             :order_id => paid_order.id)}

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

  let!(:orders) {{"pending"  => pending_order,
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
      page.should_not have_content(other_user_order)
    end

    it "finds an order by product title/description via the search form" do
      login(user)
      visit "/orders"
      within("#orders_index") do
        fill_in 'search', :with => product.title
        click_link_or_button "Search"
        page.should have_content(paid_order.id)
      end
    end

  end
end