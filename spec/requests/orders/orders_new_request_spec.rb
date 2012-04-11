require 'spec_helper'

describe "Orders" do
  let(:product)     { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}
  let(:user)        { Fabricate(:user, :password => 'password',
                                   :admin => 'false') }
  
  context "when placing an order" do
    context "and I'm logged in" do
      before(:each) do
       login(user)
      end

      before(:each) do
        visit product_path(product)
        click_link_or_button "add to cart"
        visit product_path(new_product)
        click_link_or_button "add to cart"
      end

      context "and there are items in the cart" do

        it "shows a button to place the order" do
          page.should have_link("Place Order")
        end

        context "and I place the order" do
          before(:each) do
            click_link_or_button "Place Order"
          end

          it "shows what I'm buying" do
            within "#order" do
              products.each do |product|
                page.should have_content(product.title)
              end
            end
          end

          it "has a form for billing address" do
            page.should have_field("City", :type => "text")
            page.should have_field("Street", :type => "text")
            page.should have_field("Street two", :type => "text")
            page.should have_field("State", :type => "text")
            page.should have_field("Zip", :type => "text")
            page.should have_field("Country", :type => "text")
            page.should have_field("Phone number", :type => "text")
          end

          it "has a form for shipping address" do
            page.should have_field("City", :type => "text")
            page.should have_field("Street", :type => "text")
            page.should have_field("Street two", :type => "text")
            page.should have_field("State", :type => "text")
            page.should have_field("Zip", :type => "text")
            page.should have_field("Country", :type => "text")
            page.should have_field("Phone number", :type => "text")
          end

          it "has a form that accepts payment information" do
            page.should have_field("Credit card number", :type => "text")
            page.should have_field("Expiration month", :type => "text")
            page.should have_field("Expiration year", :type => "text")
            page.should have_field("Credit card verification number", :type => "text")
            page.should have_field("Cardholder name", :type => "text")
          end

          it "takes me to the confirmation page" do
            page.should have_button("Confirm")
          end
        end
      end

      context "and I fill out the form" do
        it "creates a new order via the form" do
          
          click_link_or_button "Place Order"
          within(".new_order") do
            # billing address

            fill_in 'order_billing_address_city', :with => ''
            fill_in 'order_billing_address_street', :with => ''
            fill_in 'order_billing_address_street_two', :with => ''
            fill_in 'order_billing_address_state', :with => ''
            fill_in 'order_billing_address_zipcode', :with => ''
            fill_in 'order_billing_address_country', :with => ''
            fill_in 'order_billing_address_phone_number', :with => ''

            # shipping address

            fill_in 'order_billing_address_city', :with => ''
            fill_in 'order_billing_address_street', :with => ''
            fill_in 'order_billing_address_street_two', :with => ''
            fill_in 'order_billing_address_state', :with => ''
            fill_in 'order_billing_address_zipcode', :with => ''
            fill_in 'order_billing_address_country', :with => ''
            fill_in 'order_billing_address_phone_number', :with => ''

            # credit card info / transaction

            fill_in 'order_transactions_credit_card_number', :with => ''
            fill_in 'order_transactions_expiration_month', :with => ''
            fill_in 'order_transactions_expiration_year', :with => ''
            fill_in 'order_transactions_credit_card_verification_number', :with => ''
            fill_in 'order_transactions_cardholder_name', :with => ''
          end
          click_button 'Confirm'
          current_path.should == "/orders/1/edit"
        end

      end
    end
  end

  
end