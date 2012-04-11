require 'spec_helper'

describe User do
  context "an administrator" do
    let (:user) { Fabricate(:user) }

    it "can create new products" do
      create_user(user)
      login_as(user)

      visit products_path
      click_link "New Product"

      fill_product_form

      expect {
       click_button "Create Product" 
      }.to change{ Product.all.count }.by(1)
    end
  end

  context "an unauthenticated user" do
    it "can't create new products" do
      visit new_product_path
      page.should have_content("Log in")
      page.should have_content("SIGN IN BITCH!")
    end
  end  
  describe "users with role" do
    let (:user) { Fabricate(:user) }

    context "nil" do
      before(:all) do
        user.role = nil
      end

      it "cannot visit the new product page" do
        create_user(user)
        login_as(user)
        visit new_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end

    context "'blank'" do
      before(:all) do
        user.role = nil
      end

      it "cannot visit the new product page" do
        create_user(user)
        login_as(user)
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
        create_user(user)
        login_as(user)
        visit new_product_path

        page.should have_content("Access denied. This page is for administrators only.")
        page.should have_content("Products")
      end
    end
  end
end
