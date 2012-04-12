require 'spec_helper'

describe User do
  let (:user) { Fabricate(:user) }
  let (:product) { Fabricate(:product) }
  let (:cart) { Fabricate(:cart) }

  after(:all) do
    User.destroy_all
  end

  context "with role admin can" do
    let!(:order) { Fabricate(:order) }
    let!(:category) { Fabricate(:category) }
    let!(:product) { Fabricate(:product) }

    before(:each) do
      user.set_role('admin')
      login_as(user)
    end

    describe "products" do
      before(:each) do
        user.cart = cart
        user.cart.add_product(product)
        visit admin_products_path
      end

      it "create" do
        click_link "New Product"

        fill_product_form

        expect {
         click_button "Create Product" 
        }.to change{ Product.all.count }.by(1)
      end

      it "edit" do
        click_link "Edit"
        fill_in "product_title", :with => "Shit"
        click_button "Update Product"
      end

      it "view" do
        click_link "#{product.title}"
        page.should have_content "#{product.description}"
      end
    end

    describe "category" do
      before(:each) do
        visit admin_categories_path
      end

      it "create" do
        click_link "New Category"
        fill_in "Name", :with => category.name
        click_button "Create Category"
        page.should have_content(category.name)
      end

      it "edit" do
        click_link "Edit"
        fill_in "Name", :with => "SUCKA!"
        click_button "Update Category"
        page.should have_content("SUCKA!")
      end

      it "view with associated products" do
        category.add_product(product)
        click_link "#{category.name}"
        page.should have_content("#{category.name}")
        page.should have_content("#{product.title}")
      end
    end

    it "view orders" do
      order.add_product(product)
      visit admin_orders_path
      click_link "#{order.title}"
      page.should have_content("#{order.items.first.title}")
    end
    context "edit orders and" do
      it "change quantity of products on pending orders"
      it "can't change quantity of products on non-pending orders"
      it "remove products"
      it "change the status"
    end
    it "not edit users personal data"
  end

  context "after logging in" do
    before(:each) do
      visit product_path(product)
      click_link "Add to Cart"
      login_as(user)
    end
    
    it "preserves the contents of my cart" do
      visit cart_path
      page.should have_content(product.title)
    end
  end

  context "an unauthenticated user" do
    it "can't create new products" do
      visit new_admin_product_path
      page.should have_content("Log in")
      page.should have_content("SIGN IN BITCH!")
    end
  end

  describe "with role" do
    context "nil" do
      it "cannot visit the new product page" do
        login_as(user.set_role(nil))
        visit new_admin_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end

    context "'blank'" do
      it "cannot visit the new product page" do
        login_as(user.set_role(''))
        visit new_admin_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end

    context "puppy" do
      before(:all) do
        user.role = nil
      end

      it "cannot visit the new product page" do
        login_as(user)
        visit new_admin_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end
  end
end
