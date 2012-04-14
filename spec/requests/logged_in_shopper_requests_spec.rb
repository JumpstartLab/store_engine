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
    before(:each) do
      visit user_path(user)
    end
    it "displays user information properly" do
      within ".main-content" do
        ["Change Profile", user.display_name, "Orders"].each do |good|
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
      billing = {credit_card_number: 555555555555,
                 credit_card_expiration_date: 03052013,
                 street: "One Mockingbird Lane",
                 city: "Anytown",
                 state: "VA",
                 zipcode: 22209,
                 name: "Favorite Billing",
                 card_type: 'Visa'}
      add_billing(billing)
    end
  end
end