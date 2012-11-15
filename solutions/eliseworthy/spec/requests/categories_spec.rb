require 'spec_helper'
describe Category do
  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:product_2) { Product.create(title: "title2", price: 4, description: "new desc") }
  let!(:category) { Category.create(name: "category_sample") }
  let!(:category_2) { Category.create(name: "category_no_assignments") }
  let!(:category_assignment) { CategoryAssignment.create(product_id: product.id, category_id: category.id) }
  let!(:category_assignment2) { CategoryAssignment.create(product_id: product_2.id, category_id: category.id) }

  context "logged in as a standard user" do
    before(:each) do
      visit login_path
      fill_in "email", with: user.email
      fill_in "password", with: "123"
      click_button "Log in"
    end

    describe "GET /categories" do
      it "goes to category page" do
        visit category_path(category)
        Product.all.each do |product|
          page.should have_content(product.title)
        end
      end
    end
  end

  context "logged in as an admin" do
    before(:each) do
      visit login_path
      fill_in "email", with: admin_user.email
      fill_in "password", with: "123"
      click_button "Log in"
    end

    describe "GET /categories" do
      it "can create a new category" do
        click_on "Create New Category"
        fill_in "category_name", with: "new_cat_test"
        click_button "Create Category"
        visit categories_path
        page.should have_content("new_cat_test")
      end

      it "can delete a category if there is no product attached" do
        visit categories_path
        within ("#category_#{category_2.id}") do
          click_on "Delete Category"
        end
        page.should_not have_content("#{category_2.name}")
      end

      it "can edit a category" do
        visit categories_path
        click_on "Edit Category"
        fill_in "category_name", with: "edited_cat_name"
        click_button "Update Category"
        page.should have_content("edited_cat_name")
        
      end


    end


  end
end
