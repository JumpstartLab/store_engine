require 'spec_helper'

describe "Products" do
  let!(:products) do
    (1..5).map { FactoryGirl.create(:product) }
  end
  let!(:retired_product) { FactoryGirl.create(:product, :activity => false) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin_user) { FactoryGirl.create(:user, :admin => true) }

  describe "GET /products" do
    it "works! (now write some real specs)" do
      get products_path
      response.status.should be(200)
    end
  end

  context "when I'm on the products page" do
    before(:each) { visit products_path }
    it "does not display retired products" do
      visit products_path
      page.should_not have_content(retired_product.title)
    end
  end

  context "editing products" do
    it "does not allow non-users to edit products" do
      visit(edit_product_path(products.first))
      page.should have_content("Not an admin")
    end

    it "doesn't allow non-admins to edit products" do
      login(user)
      visit(edit_product_path(products.first))
      page.should have_content("Not an admin")
    end

    it "allows admines to edit products" do
      login(admin_user)
      visit(edit_product_path(products.first))
      page.should have_content(products.first.title)
    end
  end
end
