require 'spec_helper'

describe "Instant Orders" do
  let(:product)     { Fabricate(:product)}
  let(:products)  {[product, new_product]}
  let(:billing)  { Fabricate(:address) }
  let(:shipping) { Fabricate(:address) }
  let(:credit_card) { Fabricate(:credit_card) }
  let(:user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'false') }

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
      visit_page product_path(product)
    end
    it "places an instant order" do
      click_link_or_button "Instant Checkout"
      page.should have_content("Really order #{product.title}?")
      #click_link_or_button "Confirm"
      page.should have_content "Your Order"
    end
  end

end
