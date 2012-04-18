require 'spec_helper'

describe "Products Index Requests" do
  context "products" do
    let!(:products) do
      [product_one = Fabricate(:product),
       product_two = Fabricate(:product),
       product_three = Fabricate(:product)
     ]
    end

    let!(:product1) { Fabricate(:product) }
    let!(:product2) { Fabricate(:product) }
    let!(:product3) { Fabricate(:product) }

    let!(:inactive_product) { Fabricate(:product, :retired => true) }

    before(:each) do
      visit "/products"
    end

    it "lists the products" do
      within("#products") do
        products.each do |product|
          page.should have_selector(".product")
          page.should have_selector("#product_#{product.id}")
        end
      end
    end

    it "links to the products" do
      within("#products") do
        products.each do |product|
          within("#product_#{product.id}") do
            page.should have_link(product.title)
          end
        end
      end
    end

    it "displays the product when clicking the link" do
      product = products.first
      within("#product_#{product.id}") do
        click_link(product.title)
      end
      page.should have_content(product.title)
      page.should have_content(product.description)
      page.should have_content(product.price)
      page.should have_selector("img#product_image") if product.image?
    end

    it "only shows active products" do
      page.should_not have_content(inactive_product.title)
    end

    it "finds a product via the search form" do
      visit root_url
      fill_in 'search', :with => product1.title
      click_link_or_button " "
      page.should have_content(product1.title)
      page.should_not have_content(product2.title)
      page.should_not have_content(product3.title)
    end

  end
end