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
    let!(:order) { Fabricate(:order) }
    let!(:products) { [Fabricate(:product), Fabricate(:product), Fabricate(:product)] }

    before(:each) { visit order_path(order) }

    # it "lists the order ID" do
    #   page.should have_content(order.id)
    # end

    # it "lists the user who placed the order" do
    #   pending "Need to implement users first"
    # end

    # it "lists the datetime the order was placed" do
    #   page.should have_content(order.created_at)
    # end

    # it "lists the datetime the order was updated" do
    #   page.should have_content(order.updated_at)
    # end

    # it "lists the total price of all items in the order" do
    #   page.should have_content(order.total_price)
    # end

    # it "has a list of products" do
    #   page.should have_selector("#items")
    # end

    # it "lists the products included in the order" do
    #   within("#items") do
    #     products.each do |product|
    #       page.should have_content(product.title)
    #     end
    #   end
    # end

    it "lists the quantity of each product"
    it "lists the line item price of each product"
  end

end