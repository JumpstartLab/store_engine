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

    it "not edit users personal data"

    describe "dashboard" do
      it "view total number of orders by status"

      it "click links for each order"
      it "filter by status type"

      context "order" do
        it "cancel if pending"
        it "mark as returned if shipped"
        it "mark as shipped if paid"

        context "view" do
          it "date and time"
          it "purchaser full name and address"
          it "total"
          it "status"

          describe "products" do
            it "link to product page"
            it "quantity"
            it "price"
            it "line item subtotal"
          end
        end
      end
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

    context "orders" do
      it "views" do
        order.add_product(product)
        visit admin_orders_path
        click_link "#{order.id}"
        page.should have_content("#{order.items.first.title}")
      end

      context "edit and" do
        it "change the status" do
          visit admin_orders_path
          click_link "Edit"
          fill_in "Status", :with => "shipped"
          click_button "Update Order"
          page.should have_content("shipped")
        end

        it "can't change quantity of products on non-pending orders" do
          order.status = "shipped"
          order.save
          order.add_product(product)
          visit admin_orders_path
          click_link "#{order.id}"
          page.should_not have_content("Edit")
        end

        it "remove products" do
          order.add_product(product)
          visit admin_order_path(order)
          click_link "Remove"
          page.should have_content("Item Deleted Bitch")
          page.should_not have_content(product.title)
        end

        it "change quantity of products on pending orders" do
          order.add_product(product)
          visit admin_orders_path
          click_link "Edit"
          fill_in "order_order_items_attributes_0_quantity", :with => "2"
          click_button "Update Order"
          click_link "#{order.id}"
          find(".quantity").text.should == "2"
        end
      end
    end
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
