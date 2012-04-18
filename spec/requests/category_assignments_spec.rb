require 'spec_helper'

describe CategoryAssignment do

  let!(:user) { FactoryGirl.create(:user, password: "123") }
  let!(:admin_user) { FactoryGirl.create(:user, password: "123", admin: true) }
  let!(:product) { Product.create(title: "title", price: 2, description: "desc") }
  let!(:product_2) { Product.create(title: "title2", price: 4, description: "new desc") }
  let!(:category) { Category.create(name: "category_sample") }
  let!(:category_2) { Category.create(name: "category_no_assignments") }
  let!(:category_assignment) { CategoryAssignment.create(product_id: product.id, category_id: category.id) }
  let!(:category_assignment2) { CategoryAssignment.create(product_id: product_2.id, category_id: category.id) }


  describe "CategoryAssignments" do
    describe "GET /category_assignments" do
      before(:each) do
        visit login_path
        fill_in "email", with: admin_user.email
        fill_in "password", with: "123"
        click_button "Log in"
      end

      it "allows an admin to add a category assignment to a product" do
        visit edit_product_path(product)
        save_and_open_page
      end
    end
  end
end
