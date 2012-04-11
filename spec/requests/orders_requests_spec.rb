require 'spec_helper'

describe "For orders" do
  context "#index" do
    let!(:orders) { [Fabricate(:order), Fabricate(:order)] }

    before(:each) { visit orders_path }

    it "has an area that list the orders" do
      page.should have_selector("table#orders")
    end

    it "lists orders in the system" do
      within("table#orders") do
        orders.each do |order|
          page.should have_content(order.id)
        end
      end
    end
  end

  context "#show" do
    let!(:order) { [Fabricate(:order) ] }

    before(:each) { visit order_path(order) }

    it "lists the order ID" do
      # save_and_open_page
      # raise order.inspect
      page.should have_content(order.id)
    end

    it "lists the user who placed the order"
    it "lists the datetime the order was placed"
    it "lists the datetime the order was edited"
    it "lists the total price of all items in the order"

    it "has a list of products"
    it "lists the products included in the order"
    it "lists the quantity of each product"
    it "lists the line item price of each product"

  end

end