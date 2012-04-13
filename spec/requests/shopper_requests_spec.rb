require 'spec_helper'

describe "shopper" do
  let!(:product) { Fabricate(:product) }
  context "index" do
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
      it "has a clickable listing of products" do
        page.should have_selector "##{dom_id(product)}"
        click_link_or_button product.title
        current_path.should == product_path(product)
      end
      it "has a clickable list of product categories" do
        category = Fabricate(:category)
        product.categories << category
        visit "/"
        within ".main-content" do
          page.should have_content category.name
          click_link_or_button category.name
          current_path.should == category_path(category)
        end
      end
      it "has an add to cart button" do
        page.should have_content "Add to Cart"
      end
      it "does not have admin buttons" do
        page.should_not have_content "Edit"
        page.should_not have_content "Retire"
        page.should_not have_content "Destroy"
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
        pending
        within ".cart" do
          page.should have_content "Update"
          click_link_or_button "Update"
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
      context "two-click checkout" do
        context "if the order has no billing or shipping info" do
          it "directs the user to input that information" do
            within ".cart" do
              page.should have_content "Two-Click Check Out"
              click_link_or_button "Two-Click Check Out"
            end
            current_path.should have_content "orders"
            page.should have_content "valid billing and shipping"
            page.should have_content "Add a Billing Method"
            page.should have_content "Add a Shipping Address"
          end
        end
        context "if the order has billing and shipping information" do
          it "can do two-click checkout" do
            Order.any_instance.stub(billing_method_id: 1)
            Order.any_instance.stub(shipping_address_id: 1)
            within ".cart" do
              page.should have_content "Two-Click Check Out"
              click_link_or_button "Two-Click Check Out"
            end
            current_path.should == "/"
            page.should have_content "Thank you"
          end
        end
      end
      context "regular checkout" do
        before(:each) do
          click_link_or_button "View Cart"
        end
        it "can add billing info" do
          click_link_or_button "Add a Billing Method"
          current_path.should == new_billing_method_path
          billing = {credit_card_number: 555555555555, credit_card_expiration_date: 03052013, street: "One Mockingbird Lane", city: "Anytown", state: "VA", zipcode: 22209}
          add_non_user_billing(billing)
        end
        it "can add shipping info" do
          click_link_or_button "Add a Shipping Address"
          current_path.should == new_shipping_address_path
          shipping = {street: "One Mockingbird Lane", city: "Anytown", state: "VA", zipcode: 22209, email_address: "test@test.com"}
          add_non_user_shipping(shipping)
        end
        it "can check out" do
          Order.any_instance.stub(billing_method_id: 1)
          Order.any_instance.stub(shipping_address_id: 1)
          within ".main-content" do
            page.should have_content "Check Out"
            click_link_or_button "Check Out"
          end
          current_path.should == "/"
          page.should have_content "Thank you"
        end
        it "does not checkout without valid billing" do
          shipping = Fabricate(:shipping_address)
          Order.last.update_attribute(:shipping_address_id, shipping.id)
          within ".main-content" do
            page.should have_content "Check Out"
            click_link_or_button "Check Out"
          end
          current_path.should have_content "orders"
          page.should have_content "Please input a valid billing method"
        end
        it "does not checkout without valid shipping" do
          billing = Fabricate(:billing_method)
          Order.last.update_attribute(:billing_method_id, billing.id)
          within ".main-content" do
            page.should have_content "Check Out"
            click_link_or_button "Check Out"
          end
          current_path.should have_content "orders"
          page.should have_content "Please input a valid shipping address"
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
  context "product page" do
    before(:each) do
      visit product_path(product)
    end
    context "when viewing the page" do
      it "display the product properly" do
        within ".main-content" do
          page.should have_selector "img"
          [product.title.to_s, "Add to Cart"].each do |cont|
            page.should have_content cont
          end
        end
      end
      it "does not have admin buttons" do
        within ".main-content" do
          ["Edit", "Retire", "Destroy"].each do |cont|
            page.should_not have_content cont
          end
        end
      end
    end
    it "has the cart" do
      page.should have_selector ".cart"
    end
  end
  context "category page" do
    let!(:category) { Fabricate(:category) }
    before(:each) do
      product.categories << category
      visit category_path(category)
    end
    it "has the proper content" do
      page.should have_content product.title
    end
    it "doesn't have admin stuff" do
      within ".main-content" do
        page.should_not have_content "Remove"
      end
    end
    it "has a cart" do
      page.should have_selector ".cart"
    end
  end
end