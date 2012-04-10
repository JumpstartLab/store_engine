require 'spec_helper'

describe "Products Requests" do
  context "when I view all products" do
    let!(:products) { [Fabricate(:product, :title => "Foo"), 
      Fabricate(:product, :title => "Bar")] }
    before(:each) do      
      visit "/products"
    end

    it "shows Products header" do
      page.should have_content("Products")
    end

    it "shows all of the products" do
      find_link("Foo").visible?
      find_link("Bar").visible?
    end

    it "creates a list of the products" do
      within ("li") do
        find_link("Foo").visible?
      end
    end
  end

  context "when I create a product" do
    let!(:category) { Fabricate(:category) }
    let!(:category2) { Fabricate(:category) }

    it "saves a new product" do
      visit new_product_path
      fill_in "Title", :with => "Test product"
      fill_in "Description", :with => "Test description"
      fill_in "Price", :with => "100.00"

      check "category[#{category2.name}]"

      click_button "Create Product"
      click_link "Test product"
      page.should have_content("Test product")
      page.should have_content("Test description")
      page.should have_content("100.00")
      page.should have_content(category2.name)
    end
  end

  context "when I view a product" do 
    let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

    it "shows product page" do
      visit "/products" 
      find_link("Foo").click
      current_path.should == product_path(product)
    end

    it "shows quantity selector with 30 items" do 
      visit "/products/1" 
      (1..30).each do |i| 
        select(i.to_s, :from => 'cart_item_quantity')
      end
    end

    it "has a Add to Cart submit button" do
      visit "/products/1" 
      find_button("Add to Cart").visible?
    end
  end

  context "When I click on the 'add to cart' button" do
    let!(:user) { Fabricate(:user) }
    let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

    it "redirects to the shopping cart" do
      login_user_post("admin", "admin")
      visit "/products/1"
      find_button('Add to Cart').click
      current_path.should == shopping_cart_path
    end
  end
end
