require 'spec_helper'

describe "ordering with two clicks" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:address) { FactoryGirl.create(:address, :user => user) }
  before(:each) do
    @mock_controller = mock("ApplicationController") 
    @mock_controller.stub(:current_user).and_return(user)
  end
  context "when browser is on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    let(:addresses) do
      (1..5).map { FactoryGirl.create(:address) }
    end
    
    before(:each) { visit product_path(product) }
    context "when I'm not logged in and click buy instantly" do
      it "should redirect an unlogged user to the login page" do
        click_link_or_button "Buy instantly"
        page.should have_content("You need to log in")
      end
    end

    context "when I'm logged in" do
      before(:each) do 
        login(user)
        visit product_path(product)
      end
      it "should redirect me to cart without a saved credit cart" do
        click_link_or_button "Buy instantly"
        page.should have_css('h1', :text => 'Cart')
      end

      it "the cart should contain the item i tried to buy" do
        click_link_or_button "Buy instantly"
        page.should have_content(product.title)
      end
    end

    context "when I'm logged in and and I have a saved credit cart" do
      let!(:card_user) { FactoryGirl.create(:user, :stripe_id => "cus_dHvnvCMsbUCTj") }
      let!(:address) { FactoryGirl.create(:address, :user => card_user) }

      it "buys with two clicks" do
        login(card_user)
        visit product_path(product)
        card   = valid_card_data
        charge = Stripe::Charge.create amount:      (product.price * 100).to_i,
                                   card:        card,
                                   currency:    'usd',
                                   description: "#{ card_user.email }"
        Stripe::Charge.stub!(:create).and_return(charge)     
        click_link_or_button "Buy instantly" 
        page.should have_content("Transaction Successful")
      end
    end
  end

  describe "when I'm not logged in and i click buy instantly" do
    let(:product) { FactoryGirl.create(:product) }
    it "directs me to home" do
      visit product_path(product)
      click_link_or_button "Buy instantly"
      login(user)
      page.should have_content "You need to be logged in to instant purchase."
    end
  end
end

# cus_dHvnvCMsbUCTjY