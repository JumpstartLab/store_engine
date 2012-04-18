require 'spec_helper'

describe "Products Admin Requests" do
  let!(:product) {Fabricate(:product)}
  let!(:products) do
    [product_one = product,
     product_two = Fabricate(:product),
     product_three = Fabricate(:product)
    ]
  end

  let!(:retired_sample) {Fabricate(:product, :retired => true)}
  let!(:retired) do
    [retired_one = Fabricate(:product, :retired => true),
     retired_two = Fabricate(:product, :retired => true)
    ]
  end


  context "as an admin" do
    before(:each) do
      @user = Fabricate(:user,
                        :password => 'password',
                        :admin => true)
      visit "/login"
      fill_in 'email', :with => @user.email
      fill_in 'password', :with => 'password'
      click_button 'Log in'
    end

    it "shows a link to add a product" do
      visit "admin/products"
      within("#admin_bar") do
        page.should have_link('Add a product', href: new_product_path)
      end
    end

    it "shows a button to retire a product" do
      visit "admin/products"
      products.each do |product|
        within("tr.product") do
          page.should have_link("Retire")
        end
      end
    end

    it "retires the product" do
      visit "admin/products"

      within("#product_#{product.id}") do
        click_link_or_button("Retire")
      end

      within("#active_products") do
        page.should_not have_content("#{product.title}")
      end
    end

    it "activates a retired product" do
      visit "admin/products"
      within("#product_#{retired_sample.id}") do
        click_link_or_button("Activate")
      end

      within("#retired_products") do
        page.should_not have_content("#{retired_sample.title}")
      end

      within("#active_products") do
        page.should have_content("#{retired_sample.title}")
      end
    end

    it "shows a list of active products" do
      visit "/admin/products"
      within("#active_products") do
        products.each do |product|
          page.should have_content(product.title)
        end
      end
    end

    it "shows a list of retired products" do
      visit "/admin/products"
      within("#retired_products") do
        retired.each do |product|
          page.should have_content(product.title)
        end
      end
    end

  end
end