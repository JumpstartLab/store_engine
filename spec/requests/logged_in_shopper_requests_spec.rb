require 'spec_helper'

describe "logged in user" do
  let(:user) { Fabricate(:user) }
  before(:each) do
    visit "/"
    click_link_or_button "Sign-In"
    login({email: user.email_address, password: user.password})
  end
  context "index" do
    it "has the proper header items" do
      within ".nav" do
        ["Categories", "My Account", "Logout"].each do |good|
          page.should have_content good
        end
        ["Sign-In", "Sign-Up", "Admin View"].each do |bad|
          page.should_not have_content bad
        end
      end
      ["Edit", "Retire", "Destroy"].each do |button|
        page.should_not have_content button
      end
    end
    it "can log out" do
      within ".nav" do
        click_link_or_button "Logout"
      end
      current_path.should == "/"
      page.should_not have_content "My Account"
    end
  end
  context "My Account" do
    let(:billing) {
      { credit_card_number: "5555555555555555",
            month: "4 - April",
            year: "2012",
            street: "One Mockingbird Lane",
            city: "Anytown",
            state: "Virginia",
            zipcode: "22209",
            card_type: 'Visa'
      }
    }
    let(:shipping) {
      { street: "One Mockingbird Lane",
        city: "Anytown",
        state: "Virginia",
        zipcode: "22209",
        email_address: "test@test1.com",
        name: "Favorite Billing"
      }
    }
    before(:each) do
      visit user_path(user)
    end
    it "displays user information properly" do
      within "#main-content" do
        ["Change Profile", user.display_name, "Orders"].each do |good|
          page.should have_content good
        end
      end
    end
    it "can edit it's information" do
      click_link_or_button "Change Profile"
      fill_in "Display name", with: "My New Name"
      click_link_or_button "Update Information"
      current_path.should == user_path(user)
      page.should have_content "My New Name"
    end
    it "can add billing info" do
      within "#main-content" do
        page.should have_content "Add a Billing Method"
        click_link_or_button "Add a Billing Method"
      end
      current_path.should == new_billing_method_path
      add_billing(billing)
      current_path.should == user_path(user)
      page.should have_content billing[:name]
    end
    it "can edit billing info" do
      click_link_or_button "Add a Billing Method"
      add_billing(billing)
      within "#main-content" do
        page.should have_content "Change Billing Method"
        click_link_or_button "Change Billing Method"
      end
      fill_in "Name", with: "New Favorite Billing"
      click_link_or_button "Update Billing method"
      current_path.should == user_path(user)
      page.should have_content "New Favorite Billing"
    end
    it "can add shipping info" do
      within "#main-content" do
        page.should have_content "Add a Shipping Address"
        click_link_or_button "Add a Shipping Address"
      end
      current_path.should == new_shipping_address_path
      add_shipping(shipping)
      current_path.should == user_path(user)
      page.should have_content shipping[:name]
    end
    it "can edit shipping info" do
      click_link_or_button "Add a Shipping Address"
      add_shipping(shipping)
      within "#main-content" do
        page.should have_content "Change Shipping Address"
        click_link_or_button "Change Shipping Address"
      end
      fill_in "Name", with: "New Shipping"
      click_link_or_button "Update Shipping address"
      current_path.should == user_path(user)
      page.should have_content "New Shipping"
    end
    context "orders" do
      let!(:product) { Fabricate(:product) }
      it "can view it's orders" do
        visit "/"
        click_link_or_button "Add to Cart"
        click_link_or_button "My Account"
        click_link_or_button "View Orders"
        current_path.should == orders_path
        page.should have_content product.title
      end
      it "cannot view anyone else's orders" do
        other_user = Fabricate(:user)
        order = Fabricate(:order)
        li = Fabricate(:line_item)
        li.update_attributes({product_id: product.id,
          order_id: order.id})
        order.update_attribute(:user_id, other_user.id)
        click_link_or_button "View Orders"
        within "#main-content" do
          page.should_not have_content product.title
        end
      end
      it "does not see admin stuff" do
        adm_links = ["Destroy", "Edit", "Actions", "Transition", "ID", "Name"]
        click_link_or_button "View Orders"
        within "#main-content" do
          adm_links.each do |bad|
            page.should_not have_content bad
          end
        end
      end
      it "can add item, logout, add item, login, and items are merged" do
        visit "/"
        click_link_or_button "Add to Cart"
        click_link_or_button "Logout"
        click_link_or_button "Add to Cart"
        click_link_or_button "Sign-In"
        login({email: user.email_address, password: user.password})
        within "#cart-aside" do
          page.should have_content "2"
        end
      end
    end
    context "restrictions" do
      let!(:other_user) { Fabricate(:user) }
      it "cannot see another user's account page" do
        visit user_path(other_user)
        current_path.should == "/"
        page.should have_content "not allowed"
      end
      it "cannot see another user's orders" do
        product = Fabricate(:product)
        order = Fabricate(:order)
        order.update_attribute(:user_id, other_user.id)
        li = Fabricate(:line_item)
        li.update_attributes( { product_id: product.id, order_id: order.id } )
        visit order_path(order)
        current_path.should == "/"
        page.should have_content "not allowed"
      end
      it "cannot view a list of users" do
        visit users_path
        page.should_not have_content other_user.full_name
      end
    end
  end
end
