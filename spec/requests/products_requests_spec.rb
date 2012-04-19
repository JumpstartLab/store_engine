require 'spec_helper'

describe "Products Requests" do
  context "when I view all products" do
    let!(:products) { [Fabricate(:product, :title => "Foo"), 
      Fabricate(:product, :title => "Bar")] }
    before(:each) do      
      visit products_path
    end

    it "shows all of the products" do
      find_link("Foo").visible?
      find_link("Bar").visible?
    end
  end

  context "when I view a product" do 
    let!(:product) { Fabricate(:product, :title => "Foo") }

    it "shows product page" do
      visit products_path 
      find_link("Foo").click
      current_path.should == product_path(product)
    end

    it "shows quantity selector with 30 items" do 
      visit product_path(product)
      (1..30).each do |i| 
        select(i.to_s, :from => 'cart_item_quantity')
      end
    end

    it "has a Add to Cart submit button" do
      visit product_path(product)
      find_button("Add to Cart").visible?
    end
  end

  context "When I click on the 'add to cart' button" do
    let!(:user) { Fabricate(:user) }
    let!(:product) { Fabricate(:product, :id => 1, :title => "Foo") }

    it "redirects to the shopping cart" do
      login_user_post("admin", "admin")
      visit product_path(product)
      find_button('Add to Cart').click
      current_path.should == shopping_cart_path
    end
  end
end
