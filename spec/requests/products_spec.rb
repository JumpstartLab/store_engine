require 'spec_helper'

describe Product do
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:order) { FactoryGirl.create(:order) }
  let!(:order_item) { OrderItem.create(order: order, product: product, quantity: 1, price: 2) }




  context "the user is logged in as an admin" do
    before(:each) do
      visit login_path
      fill_in "email", with: admin_user.email
      fill_in "password", with: "123"
      click_button "Log in"
      visit products_path
    end

    describe "GET /products" do
      it "displays all active and retired products" do
        Product.all.each do |product|
          page.should have_content(product.title)
        end
      end

      it "enables admin to change product prices" do
        visit edit_product_path(product)
        fill_in "Description", with: "this is new description"
        click_button "Update Product"
        visit product_path(product)
        page.should have_content("this is new description")
      end
    end

    describe "POST /product" do
      it "is enables admins to add a product" do
        visit new_product_path
        fill_in "Title", with: "test_product"
        fill_in "Description", with: "test_product description"
        fill_in "Price", with: 3.40
        fill_in "Photo", with: "http://www.sample.jpeg"
        click_button "Create Product"
        visit products_path
        page.should have_content("test_product")
      end
    end
  end

  context "the user is logged in as a shopper" do
    before(:each) do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "123"
      click_button "Log in"
      visit products_path
    end

    describe "GET /products" do
      it "displays all active and retired products" do
        Product.all.each do |product|
          if product.retired == false
            page.should have_content(product.title)
          end
        end
      end
    end


    describe "GET /product" do
      it "displays information on the product" do
        visit product_path(product)
        page.should have_content(product.title)
        page.should have_content(product.description)
        page.should have_content(product.price)
      end
    end
  end
end