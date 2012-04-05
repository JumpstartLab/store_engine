require 'spec_helper'

describe "Product Show Requests" do
  context "as an admin" do
    let!(:products) do
      [product_one = Fabricate(:product),
       product_two = Fabricate(:product),
       product_three = Fabricate(:product)
     ]
    end

    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      visit "/login"
      fill_in 'email', :with => @user.email
      fill_in 'password', :with => 'password'
      click_button 'Log in'
    end

    it "shows a link to edit a product" do
      product = products.first
      visit "/products/#{product.id}"
      within("ul#options") do
        page.should have_link('Edit Product', href: edit_product_path(product))
      end
    end

    it "shows a link to delete a product" do
      product = products.first
      visit "/products/#{product.id}"
      within("ul#options") do
        page.should have_link('Delete Product', href: product_path(product))
      end
    end

    it "shows a link to all products" do
      product = products.first
      visit "/products/#{product.id}"
      within("ul#options") do
        page.should have_link('All Products', href: products_path)
      end
    end
  end
end