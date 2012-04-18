require 'spec_helper'

describe "Instant Orders" do
  let(:product)     { Fabricate(:product)}
  let(:products)  {[product, new_product]}
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:credit_card) { Fabricate(:credit_card) }
  let(:user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'false') }

  let(:user2)       { Fabricate(:user,
                                :password => 'password',
                                :admin => 'false')}

  before(:each) do
    user.addresses << billing
    user.addresses << shipping
    user.credit_cards << credit_card
    user.save
    user.set_default_shipping_address_by_id(shipping.id)
    user.set_default_billing_address_by_id(billing.id)
    user.set_default_credit_card_by_id(credit_card.id)
  end

  context "when viewing a product page" do
    before(:each) do
      visit product_path(product)
    end

    context "and I try to place an instant order" do

      context "and the user has set their defaults" do
        before(:each) do
          # using user with defaults set above
          login(user)
          visit product_path(product)
          click_link_or_button "Instant Checkout"
        end

        it "places an instant order" do
          # click_link_or_button "Confirm"
          page.should have_content "Your Order"
        end
      end

      context "and the user hasn't set their defaults" do
        before(:each) do
          # using user without defaults
          login(user2)
          visit product_path(product)
          click_link_or_button "Instant Checkout"
        end

        it "redirects to user profile if no default billing info" do
          current_path.should == user_path(user2)
          page.should have_link("Add a default billing address")
        end
      end

      context "and something goes wrong" do
        before(:each) do
          # using user without defaults
          login(user)
          visit product_path(product)
          click_link_or_button "Instant Checkout"
        end

        it "redirects back to the previous page" do
          pending
          # Order.stub(:create) { mock_model(Order, :save => false) }
          # current_path.should == "/"
        end
      end
    end

  end

end
