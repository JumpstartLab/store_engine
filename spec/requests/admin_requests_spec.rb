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
  context "another user's order" do
    let!(:order) {
      ord = Fabricate(:order)
      ord.update_attributes({billing_method_id: nil, shipping_address_id: nil})
      ord
    }
    let!(:product) { Fabricate(:product) }
    let!(:line_item) {
      li = Fabricate(:line_item)
      li.update_attributes( { product_id: product.id, order_id: order.id} )
      li
    }
    before(:each) do
      other_user = Fabricate(:user)
      order.update_attribute(:user_id, other_user.id)
      visit order_path(order)
    end
    it "can see another user's order" do
      current_path.should have_content "orders"
      page.should have_content product.title
    end
    it "cannot edit another user's billing on an order" do
      pending
      click_link_or_button "Add a Billing Method"
      current_path.should == "/"
      page.should have_content "Sorry"
    end
    it "cannot edit another user's shipping on an order" do
      pending
      click_link_or_button "Add a Shipping Address"
      current_path.should == "/"
      page.should have_content "Sorry"
    end
    it "can edit the quantity of a product on an order" do
      click_link_or_button "Update"
      page.should have_content "Quantity"
      fill_in "Quantity", with: "2"
      click_link_or_button "Update Quantity"
      within ".main-content" do
        page.should have_content "2"
      end
    end
  end
  context "product" do
    let!(:product) { Fabricate(:product) }
    before(:each) do
      visit product_path(product)
    end
    it "has admin buttons" do
      ["Edit", "Retire", "Destroy"].each do |button|
        page.should have_content button
      end
    end
    it "can edit a product" do
      click_link_or_button "Edit"
      fill_in "Title", with: "Other Product"
      click_link_or_button "Update Product"
      page.should_not have_content product.title
      page.should have_content "Other Product"
    end
    it "can destroy a product" do
      click_link_or_button "Destroy"
      page.should_not have_content product.title
    end
    it "can retire a product" do
      pending
      click_link_or_button "Retire"
      click_link_or_button "User View"
      page.should_not have_content product.title
    end
  end
  context "user"
  context "category"
end