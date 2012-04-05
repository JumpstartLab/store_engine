require 'spec_helper'

describe "when viewing an order" do

  let(:order) {FactoryGirl.create(:order)}
    
  before(:each) { visit order_path(order) }

  it "includes purchaser name" do
    page.should have_content(order.user.full_name)
  end

  it "includes purchaser email" do
    page.should have_content(order.user.email)
  end

  # Fix this spec
  # context "if there is more than one order item" do
  #   it "shows all order items" do
  #     order.order_items.each do |oi|
  #       page.should have_content(oi.product.title)
  #     end
  #   end
  # end
end