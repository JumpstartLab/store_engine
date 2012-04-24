require 'spec_helper'

describe "Product" do 
  let(:product) { FactoryGirl.create(:product)}   
  context "Logged Out" do
    it "can't edit products" do
      visit edit_admin_product_path(product)
      page.should have_content("You must login first")
    end
    it "can't create a new product" do
      visit new_admin_product_path
      page.should have_content("You must login first")
    end
    context "Browsing" do
      it "Browse all products" do
        visit products_path
        page.should have_content("Products")
      end
    end
  end
  context "Auth" do
    before(:each) do
      login(user)
    end
    context "User" do
      let!(:user) do
        FactoryGirl.create(:user, :password => "mike")
      end
      it "can't edit products" do
        visit edit_admin_product_path(product)
        page.should have_content("Must be an administrator")
      end
      it "can't create a new product" do
        visit new_admin_product_path
        page.should have_content("Must be an administrator")
      end
    end
    context "Admin" do
      let!(:user) do
        FactoryGirl.create(:admin, :password => "mike")
      end
      context "Product modification" do
        it "Edit Passes" do
          visit edit_admin_product_path(product)
          fill_in "product[name]", :with => "Mooo"
          click_on "Save Product"
          page.should have_content "Product updated."
        end
        it "Edit Fails" do
          visit edit_admin_product_path(product)
          page.should have_content("Edit Product")
          fill_in "product[name]", :with => ""
          click_on "Save Product"
          page.should have_content "can't be blank"          
        end    
      end
      context "Creating a product" do
        it "can create a new product" do
          visit new_admin_product_path
          fill_in "product[name]", :with => "fooo123#{rand(2342342342)}"
          fill_in "product[description]", :with => "MY AWESOME PRODUCT"
          fill_in "product[price]", :with => "234"
          click_on "Save Product"
          page.should have_content "Product created."
        end
        it "validation fails" do
          visit new_admin_product_path
          fill_in "product[description]", :with => "MY AWESOME PRODUCT"
          fill_in "product[price]", :with => "234"
          click_on "Save Product"
          page.should have_content "can't be blank"
        end        
      end
      context "Removing a product" do
        it "Deletes a product" do
          visit product_path(product)
          click_link("Delete item")
          page.should have_content("Product Removed")
        end
        it "Verify product isn't shown" do
          visit products_path
          page.should_not have_content(product.name)
        end
      end
    end
  end
end