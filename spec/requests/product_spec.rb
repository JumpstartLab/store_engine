require 'spec_helper'

describe "Product" do 
  let(:product) { FactoryGirl.create(:product)}   
  context "Logged Out" do
    it "can't edit products" do
      visit edit_product_path(product)
      page.should have_content("Must be an administrator")
    end
    it "can't create a new product" do
      visit new_product_path
      page.should have_content("Must be an administrator")
    end
    context "Browsing" do
      it "Browse all products" do
        visit '/products'
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
        visit edit_product_path(product)
        page.should have_content("Must be an administrator")
      end
      it "can't create a new product" do
        visit new_product_path
        page.should have_content("Must be an administrator")
      end
    end
    context "Admin" do
      let!(:user) do
        FactoryGirl.create(:admin, :password => "mike")
      end
      it "can edit products" do
        visit edit_product_path(product)
        page.should have_content("Edit Product")
      end
      it "can create a new product" do
        visit new_product_path
        page.should have_content("New Product")        
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