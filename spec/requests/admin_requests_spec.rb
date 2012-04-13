require 'spec_helper'

describe "admin" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product) }
  before(:each) do
    user.update_attribute(:admin, true)
    user.update_attribute(:admin_view, true)
    visit "/"
    click_link_or_button "Sign-In"
    login({email: user.email_address, password: user.password})
  end
  context "index" do
    it "has the proper header items" do
      within ".nav" do
        ["Categories", "My Account", "Logout", "User View"].each do |good|
          page.should have_content good
        end
        ["Sign-In", "Sign-Up"].each do |bad|
          page.should_not have_content bad
        end
      end
    end
    it "has admin buttons" do
      within ".main-content" do
        ["Edit", "Retire", "Destroy"].each do |button|
          page.should have_content button
        end
      end
    end
    it "can switch to user view" do
      click_link_or_button "User View"
      ["Edit", "Retire", "Destroy"].each do |button|
        page.should_not have_content button
      end
    end
    it "can switch back to admin view" do
      click_link_or_button "User View"
      click_link_or_button "Admin View"
      ["Edit", "Retire", "Destroy"].each do |button|
        page.should have_content button
      end
    end
  end
  context "order"
  context "product"
  context "user"
  context "category"
end