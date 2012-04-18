require 'spec_helper'

describe "When I am placing an order" do
  #before(:each) { visit new_order_path }
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_user_post(user.email, "foobar")
    visit new_order_path 
  end

  context "and I submit enter invalid information" do
    before(:each) do
       save_and_open_page
      fill_in "Credit Card Number", with: 123
      click_link_or_button('Create Credit card')
    end
    
    it "should stay on the current page" do
      save_and_open_page
      page.should have_content("New Order")
    end
  end

  context "and I enter valid information" do
    before do
      fill_in "Credit Card Number", with: 4242424242424242
      fill_in "Security Code on Card (CVV)", with: 234
      select("1 - January", from: :card_month)
      select("2013", from: "card_year")
    end

    it "takes me to the order confirmation page"
    # need to figure out some way to test without making an inline API call
  end
end