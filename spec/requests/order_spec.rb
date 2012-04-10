require 'spec_helper'

describe "Indivdiaul Order" do
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

  end
  it "displays if cancelled timestamp" do

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
  context "Generates new order" do
    let!(:user) do 
      FactoryGirl.create(:user, :password => "mike")
    end 
    let!(:products) do
      (1..4).map { FactoryGirl.create(:product)}
    end
    let!(:cart) do
      FactoryGirl.create(:cart, :user => user, :products => products)
    end
    before(:each) do
      login(user)
    end
    it "Should have order information" do
      page.should have_content(products[1].name)
      
    end
  end
end