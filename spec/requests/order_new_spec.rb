require 'spec_helper'

describe "Order New" do
  let!(:user) do
    FactoryGirl.create(:user, :password => "mike", :stripe_id => "cus_WyPWX06WqQhlXo")
  end 
  let!(:products) do
    (1..4).map { FactoryGirl.create(:product)}
  end
  context "Generating a new order" do
    before(:each) do
      login(user)
      products.each do |p|
        visit product_path(p)
        click_on "Add To Cart"
      end      
    end
    it "displays total" do
      pending
    end
    it "Address Updated with valid address" do
      visit cart_path
      click_on "Checkout"
      fill_in "order[user_attributes][street]", :with => "1375 Kenyon Street Nw"
      fill_in "order[user_attributes][zipcode]", :with => "20010"
      click_on "Pay"
      user.address.state.should == "District of Columbia"
    end
    it "Address failed with invalid address" do
      visit cart_path
      click_on "Checkout"
      fill_in "order[user_attributes][street]", :with => "sfsdfdsfsd"
      fill_in "order[user_attributes][zipcode]", :with => "32322343"
      click_on "Pay"
      #save_and_open_page
    end
  end
end