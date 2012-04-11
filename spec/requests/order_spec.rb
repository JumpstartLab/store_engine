require 'spec_helper'

describe "Indivdiaul Order" do
  it "Should be redirected if not logged in" do
    visit "/orders/new"
    page.should have_content "You must login first"
  end
  it "Displays Order Date & Time" do
    pending
  end
  it "Purchasers name & email" do
    pending
  end
  it "Accessible at special URL" do
    pending
  end
  it "total price" do
    pending
  end
  it "displays when shipped timestamp" do
    pending
  end
  it "displays if cancelled timestamp" do
    pending
  end
  context "Each Product Needs" do
    it "Name with Link" do
      pending
    end
    it "Quantity" do
      pending
    end
    it "Price" do
      pending
    end
    it "Line item subtotal" do
      pending
    end
    it "Status of the order" do
      pending
    end
    it "Links to transition to other statuses as explained above" do
      pending
    end
  end
end