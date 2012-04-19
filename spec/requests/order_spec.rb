require 'spec_helper'
include ActionView::Helpers::NumberHelper

describe 'viewing all orders' do
  describe 'when user is not logged in' do
    it "it redirects to login page" do
      visit "/orders"
      page.should have_content "You need to log in first."
    end
  end

  describe 'when user is logged in' do
    let!(:test_user) { FactoryGirl.create(:user) }
    let!(:test_products) do
      (1..5).map { FactoryGirl.create(:product) }
    end

    let!(:order) { FactoryGirl.create(:order, :user => test_user) }
    let!(:order_item_1) { FactoryGirl.create(:order_item, :unit_price => 100, 
      :quantity => 2, :product => test_products.first, :order => order) }
    let!(:order_item_2) { FactoryGirl.create(:order_item, :unit_price => 200, 
      :quantity => 2, :product => test_products.last, :order => order) }
    let!(:oo) { [order_item_1, order_item_2] }
    
    it "shows the user's orders" do
      login(test_user)
      visit "/orders"
      page.should have_content test_products.first.title
    end
  end
end
  
describe 'checking out' do
  let(:user) { FactoryGirl.create(:user) } 
  it "redirects to login if the user is not logged in" do
    visit "/orders/new"
    page.should have_content "You need to log in first."
  end
  context "when user is logged in" do
    before(:each) { login(user) }
    it "prevents user from checking out with no items in cart" do
      visit "/orders/new"
      page.should have_content "You can't order something"
    end

    context "when user is logged in and has items in cart the checkout page" do
      let(:products) do
        (1..5).map { FactoryGirl.create(:product) }
      end
      let(:test_cart) { FactoryGirl.create(:cart, :products => products)}
      before(:each) { load_cart_with_products(products) }
      it "takes me to checkout when i click checkout" do
        click_link_or_button "Checkout"
        page.should have_content "Checkout page"
      end

      it "checkout page contains the total for my order" do
        click_link_or_button "Checkout"
        page.should have_content(number_to_currency(test_cart.total_price))
      end

      it "enters valid data" do
        click_link_or_button "Checkout"
        page.should have_content(number_to_currency(test_cart.total_price))
        fill_in "card_number", :with => "4242424242424242"
        fill_in "card_code", :with => "343"
        select('2014', :from => 'card_year')
        fill_in "order[address_attributes][street_1]", with: "3 Derby Ln" 
        fill_in "order[address_attributes][city]", with: "Sunnydale"
        fill_in "order[address_attributes][state]", with: "DC" 
        fill_in "order[address_attributes][zip_code]", with: "24242" 
        click_on "Place order"
        page.should have_content "Transaction Complete"
      end
    end
  end

  describe "admin actions" do
    let!(:test_user) { FactoryGirl.create(:user) }
    let!(:admin_user) { FactoryGirl.create(:user, :admin => true) }
    let!(:test_products) do
      (1..5).map { FactoryGirl.create(:product) }
    end

    let!(:order) { FactoryGirl.create(:order, :user => admin_user) }
    let!(:order_item_1) { FactoryGirl.create(:order_item, :unit_price => 100, 
      :quantity => 2, :product => test_products.first, :order => order) }
    let!(:order_item_2) { FactoryGirl.create(:order_item, :unit_price => 200, 
      :quantity => 2, :product => test_products.last, :order => order) }
    let!(:oo) { [order_item_1, order_item_2] }

    it "lets me edit the order" do
      login(admin_user)
      visit edit_order_path(order)
      page.should have_content "Order Status"
    end

    # it "edits the order" do
    #   login(admin_user)
    #   visit edit_order_path(order)
    #   select('shipped', :from => 'order[status]')
    #   # save_and_open_page
    #   click_on "Update Order"
    # end
  end
end