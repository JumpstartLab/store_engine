require 'spec_helper'

describe User do
  let (:user) { Fabricate(:user) }
  let (:product) { Fabricate(:product) }

  after(:all) do
    User.destroy_all
  end

  context "with role admin can" do
    before(:each) do
      user.set_role('admin')
      login_as(user)
    end

    describe "products" do
      before(:each) do
        visit products_path
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

      end
      it "view"
    end

    it "create categories"
    it "edit categories"
    it "view categories"
    it "view orders"
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
      visit new_product_path
      page.should have_content("Log in")
      page.should have_content("SIGN IN BITCH!")
    end
  end

  describe "with role" do
    context "nil" do
      it "cannot visit the new product page" do
        login_as(user.set_role(nil))
        visit new_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end

    context "'blank'" do
      it "cannot visit the new product page" do
        login_as(user.set_role(''))
        visit new_product_path

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
        visit new_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end
  end
end
