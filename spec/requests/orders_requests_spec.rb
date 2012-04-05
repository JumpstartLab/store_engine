require 'spec_helper'

describe "Orders Requests" do
  context "show" do
    let(:order) do
      o = Fabricate(:order)
      o.products << Fabricate(:product)
      o.products << Fabricate(:product)
      o.products << Fabricate(:product)
      double_product = Fabricate(:product)
      o.products << double_product
      o.products << double_product
      o
    end

    it "has product titles for an order" do
      visit order_path(order)
      order.products.each do |product|
        page.should have_content product.title
      end
    end

    it "has product subtotals for an order" do
      visit order_path(order)
      order.products.each do |product|
        page.should have_content order.subtotal(product)
      end
    end

    it "has product quantities for an order" do
      visit order_path(order)
      order.products.each do |product|
        page.should have_content order.quantity_for(product)
      end
    end

    it "has a price for each product in an order" do
      visit order_path(order)
      order.products.each do |product|
        page.should have_content product.price
      end
    end
  end
end