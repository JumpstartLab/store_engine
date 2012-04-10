require 'spec_helper'

describe "Orders" do
  let(:product)   { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:user)      { Fabricate(:user, :password => 'password',
                                   :admin => 'false')}
  
  context "when placing an order" do
    context "and I'm logged in" do
      before(:each) do
         visit "/login"
        fill_in 'email', :with => user.email
        fill_in 'password', :with => 'password'
        click_button 'Log in'
      end

      context "and there are items in the cart" do
        before(:each) do
          visit product_path(product)
          click_link_or_button "add to cart"
          visit product_path(new_product)
          click_link_or_button "add to cart"
        end

        it "shows a button to place the order" do
          page.should have_link("Place Order", :href => "/place_order" )
        end

        context "and I place the order" do
          before(:each) do
            click_link_or_button "Place Order"
          end
          it "takes me to the payment page" do
            pending
            # page.should have_link("Pay")
          end
        end
      end
    end
  end

  
end