require 'spec_helper'

describe "Product Edit Requests" do
  context "as an admin" do
    let!(:products) do
      [product_one = Fabricate(:product),
       product_two = Fabricate(:product),
       product_three = Fabricate(:product)
     ]
    end
    let!(:retired) do
      [retired_one = Fabricate(:product, :retired => true),
       retired_two = Fabricate(:product, :retired => true)
      ]
    end

    let!(:category) { Fabricate(:category) }

    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      login(@user)
    end

    it "there is an option to add a category to a product" do
      product = products.first
      visit edit_product_path(product)
      within(".edit_product") do
        page.should have_content("Add Categories")
        page.should have_content("#{category.name}")
      end
    end

    it "adding a category saves the product with the category" do
      product = products.first
      visit edit_product_path(product)
      check("#{category.name}")
      click_button 'Update Product'
      visit "/categories"
      click_link("#{category.name}")
      page.should have_link(product.title, href: product_path(product))
    end

    it "allows you to remove a category from the product" do
      product = products.first
      visit edit_product_path(product)
      check("#{category.name}")
      click_button 'Update Product'
      visit edit_product_path(product)
      uncheck("#{category.name}")
      click_button 'Update Product'
      visit "/categories"
      click_link("#{category.name}")
      page.should_not have_content(product.title)
    end

  end
end
