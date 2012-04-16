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
      within "#main-content" do
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
  context "orders" do
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
      within "#main-content" do
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
      within ".product-title" do
        page.should_not have_content product.title
        page.should have_content "Other Product"
      end
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
    it "doesn't allow missing product information" do
      visit new_product_path
      click_link_or_button "Create Product"
      current_path.should == products_path
      page.should have_content "errors"
    end
  end
  context "user" do
    let!(:other_user) { Fabricate(:user) }
    it "cannot edit another user's information" do

      visit user_path(other_user)
      click_link_or_button "Change Profile"
      current_path.should == "/"
      page.should have_content "not allowed"
    end
    it "can view a list of users" do
      visit users_path
      page.should have_content other_user.full_name
    end
  end
  context "category" do
    before(:each) do
      visit new_category_path
      fill_in "Name", with: "baseballs"
      click_link_or_button "Create Category"
    end
    it "can create a category" do
      current_path.should have_content "baseballs"
    end
    it "can edit a category" do
      visit category_path(Category.last)
      click_link_or_button "Edit"
      fill_in "Name", with: "tennis equipment"
      click_link_or_button "Update Category"
      current_path.should == category_path(Category.last)
      page.should_not have_content "baseballs"
      page.should have_content "tennis equipment"
    end
    it "can delete a category" do
      visit category_path(Category.last)
      click_link_or_button "Destroy"
      current_path.should == categories_path
      page.should_not have_content "baseballs"
    end
  end
end