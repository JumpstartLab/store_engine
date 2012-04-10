require 'spec_helper'

describe "Products Requests" do
  context "root" do
    let!(:products) { [Fabricate(:product), Fabricate(:product)] }

    before(:each) { visit "/" }

    it "links to the product" do
      products.each do |product|
        page.should have_selector("##{dom_id(product)}")
        page.should have_link(product.title, href: product_path(product))
      end
    end
  end
  context "new" do
    before(:each) { visit new_product_path }
    it "has a form with all of the correct fields" do
      within ("form#new_product") do
        Product.new.attributes.keys[1..-3].each do |key|
          page.should have_selector("input#product_#{key}")
        end
      end
    end
  end
  context "create" do
    before(:each) do
      @count = Product.all.count
      visit new_product_path
      fill_in "product_title", with: "Test"
      fill_in "product_description", with: "Test"
      fill_in "product_price", with: 1
      click_button 'Create Product'
    end
    it "creates a product" do
      Product.all.count.should == @count + 1
    end
    it "redirects to the product" do
      current_path.should == product_path(Product.all.last)
    end
  end
  context "delete" do
    before(:each) do
      visit "/"
      click_link "Sign-Up"
      fill_in "Full name", with: "Test"
      fill_in "Email address", with: "testing@test.com"
      fill_in "Password", with: "test"
      fill_in "Password confirmation", with: "test"
      click_link_or_button "Create User"
      click_link "Sign-In"
      fill_in "Email", :with => "testing@test.com"
      fill_in "Password", :with => "test"
      click_link_or_button "sign_in_button"
      visit new_product_path
      fill_in "product_title", with: "Test"
      fill_in "product_description", with: "Test"
      fill_in "product_price", with: 1
      click_button 'Create Product'
      @count = Product.all.count
      visit product_path(Product.all.last)
      click_link 'Destroy'
    end
    # it "deletes a product" do
    #   Product.all.count.should == @count - 1
    # end
    # it "redirects to the index" do
    #   current_path.should == products_path
    # end
  end
  context "update" do
    before(:each) do
      visit new_product_path
      fill_in "product_title", with: "Test"
      fill_in "product_description", with: "Test"
      fill_in "product_price", with: 1
      click_button 'Create Product'
      visit edit_product_path(Product.all.last)
      fill_in "product_description", with: "Updated"
      click_button 'Update Product'

    end
    it "updates a product" do
      Product.last.description.should == "Updated"
    end
    it "redirects to the product" do
      current_path.should == product_path(Product.all.last)
    end
  end
end