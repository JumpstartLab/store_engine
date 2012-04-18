require 'spec_helper'

describe "Dashboard" do
  let (:user) { Fabricate(:user) }
  let (:product) { Fabricate(:product) }
  let (:cart) { Fabricate(:cart) }
  let (:order) { Fabricate(:order) }
  let! (:pending_order) { Fabricate(:order, :status => "pending") }
  let! (:paid_order) { Fabricate(:order, :status => "paid") }
  let! (:shipped_order) { Fabricate(:order, :status => "shipped") }
  let! (:cancelled_order) { Fabricate(:order, :status => "cancelled") }
  let! (:returned_order) { Fabricate(:order, :status => "returned") }
  let (:address) { Fabricate(:address) }

  before(:each) do
    order.add_product(product)
    visit admin_dashboard_path
  end

  it "view total number of orders by status" do
    Order.statuses.each do |status|
      find("#orders_by_status").should have_content("#{status}")
    end
    count_by_status = Order.find_all_by_status(order.status).count
    find(".#{order.status}_total").should have_content(count_by_status)
  end

  it "click links for each order" do
    page.should have_link("#{order.id}", :href => admin_order_path(order))
  end

  it "filter by status type" do
    visit admin_dashboard_path
    click_link "pending"
    page.should_not have_link("#{paid_order.id}")
  end

  context "order" do
    it "cancel if pending" do
      find("#order_#{pending_order.id}").should have_link("Cancel")
      find("#order_#{pending_order.id}").click_link "Cancel"
      Order.find(pending_order.id).status.should == "cancelled"
    end

    it "mark as returned if shipped" do
      find("#order_#{shipped_order.id}").should have_link("Mark as Returned")
      find("#order_#{shipped_order.id}").click_link "Mark as Returned"
      Order.find(shipped_order.id).status.should == "returned"
    end

    it "mark as shipped if paid" do
      find("#order_#{paid_order.id}").should have_link("Mark as Shipped")
      find("#order_#{paid_order.id}").click_link "Mark as Shipped"
      Order.find(paid_order.id).status.should == "shipped"
    end

    context "view" do
      before(:each) do
        order.update_attributes(:address_id => address.id)
        order.update_attributes(:user_id => user.id)
        visit admin_order_path(order)
      end

      it "date and time" do
        page.should have_content(order.created_at.to_s)
      end

      it "purchaser full name and address" do
        page.should have_content(user.name)
        page.should have_content(order.address.street)
        page.should have_content(order.address.city)
        page.should have_content(order.address.state)
        page.should have_content(order.address.zipcode)
      end

      it "status" do
        page.should have_content(order.status)
      end

      it "total" do
        find("h2").should have_content(order.total)
      end

      describe "products" do
        it "link to product page" do
          page.should have_link(product.title)
        end

        it "quantity" do
          page.should have_content(order.items.first.quantity)
        end

        it "price" do
          page.should have_content(order.items.first.price)
        end

        it "line item subtotal" do
          page.should have_content(order.items.first.subtotal)
        end
      end
    end
  end
end
