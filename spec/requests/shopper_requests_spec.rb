require 'spec_helper'

describe "shopper" do
  let!(:product) { Fabricate(:product) }
  before(:each) do
    visit "/"
  end
  context "homepage layout" do
    context "header" do
      it "has the proper header" do
        page.should have_content "The Urban Cyclist"
        page.should have_content "Categories"
        page.should have_content "Sign-In"
        page.should have_content "Sign-Up"
        page.should have_content "Contact Us"
      end
    end
    it "has a listing of products" do
      page.should have_selector "##{dom_id(product)}"
    end
    it "has an add to cart button" do
      page.should have_content "Add to Cart"
    end
  end
  context "checking out" do
    before(:each) { click_link_or_button "Add to Cart" }
    it "can add an item to the cart" do
      within ".cart" do
        page.should have_content product.title
      end
    end
    it "does not overwrite cart items" do
      product2 = Fabricate(:product)
      visit "/"
      within "##{dom_id(product2)}" do
        click_link_or_button "Add to Cart"
      end
      within ".cart" do
        page.should have_content product.title
      end
    end
    it "increments products" do
      click_link_or_button "Add to Cart"
      within "#cart_item_unit" do
        page.should have_content "2"
      end
    end
    it "removes a product" do
      within ".cart" do
        page.should have_content "Remove"
        click_link_or_button "Remove"
      end
      within ".cart" do
        page.should_not have_content product.title
      end
    end
    it "views the cart" do
      within ".cart" do
        page.should have_content "View Cart"
        click_link_or_button "View Cart"
      end
      current_path.should have_content "orders"
    end
    context "one-click checkout" do
      context "if the order has no billing or shipping info" do
        it "directs the user to input that information" do
          within ".cart" do
            page.should have_content "One-Click Check Out"
            click_link_or_button "One-Click Check Out"
          end
          current_path.should have_content "orders"
          page.should have_content "valid billing and shipping"
          page.should have_content "Add a Billing Method"
          page.should have_content "Add a Shipping Address"
        end
      end
      context "if the order has billing and shipping information" do
        it "can do one-click checkout" do
          # Order.any_instance.stub(has_billing_method?: true)
          # Order.any_instance.stub(has_shipping_address?: true)
          Order.any_instance.stub(billing_method_id: 1)
          Order.any_instance.stub(shipping_address_id: 1)
          within ".cart" do
            page.should have_content "One-Click Check Out"
            click_link_or_button "One-Click Check Out"
          end
          current_path.should == "/"
          page.should have_content "Thank you"
        end
      end
    end
    context "signing up" do
      it "can sign up" do
        click_link_or_button "Sign-Up"
        page.should have_selector ".new_user"
        sign_up({full_name: "Test User", email: "test@test.com", password: "test", display_name: "Test"})
        current_path.should == "/"
        page.should have_content "Welcome"
        page.should have_content "My Account"
      end
    end
    context "signing in" do
      it "creates a new session with this user" do
        user = Fabricate(:user)
        click_link_or_button "Sign-In"
        login({email: user.email_address, password: user.password})
        current_path.should == "/"
        page.should have_content "Welcome"
        page.should have_content "My Account"
      end
    end
  end
end