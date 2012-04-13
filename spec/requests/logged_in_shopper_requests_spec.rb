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
    end
  end
  context "My Account" do
    let(:billing) {{credit_card_number: 555555555555, credit_card_expiration_date: 03052013, street: "One Mockingbird Lane", city: "Anytown", state: "VA", zipcode: 22209, name: "Favorite Billing"}}
    let(:shipping) {{street: "One Mockingbird Lane", city: "Anytown", state: "VA", zipcode: 22209, name: "Favorite Billing"}}
    before(:each) do
      visit user_path(user)
    end
    it "displays user information properly" do
      within ".main-content" do
        ["Edit", user.display_name, "Orders"].each do |good|
          page.should have_content good
        end
      end
    end
    it "can add billing info" do
      within ".main-content" do
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
      within ".main-content" do
        page.should have_content "Change Billing Method"
        click_link_or_button "Change Billing Method"
      end
      fill_in "Name", with: "New Favorite Billing"
      click_link_or_button "Update Billing method"
      current_path.should == user_path(user)
      page.should have_content "New Favorite Billing"
    end
    it "can add shipping info" do
      within ".main-content" do
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
      within ".main-content" do
        page.should have_content "Change Shipping Address"
        click_link_or_button "Change Shipping Address"
      end
      fill_in "Name", with: "New Favorite Shipping"
      click_link_or_button "Update Shipping address"
      current_path.should == user_path(user)
      page.should have_content "New Favorite Shipping"
    end
  end
end