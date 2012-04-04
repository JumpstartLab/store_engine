require 'spec_helper'

describe "Products Index Requests" do
  context "products" do
    let!(:products) do
      [product_one = Fabricate(:product),
       product_two = Fabricate(:product),
       product_three = Fabricate(:product)
     ]
    end

    before(:each) do
      visit "/products"
    end

    it "lists the products" do
      within("#products") do
        products.each do |product|
          page.should have_selector("div.product")
          page.should have_selector("div##{product.id}")
        end
      end
    end

    it "links to the products" do
      within("#products") do
        products.each do |product|
          within("div##{product.id}") do
            page.should have_link(product.title)
          end
        end
      end
    end

    it "displays the product when clicking the link" do
      product = products.first
      within("div##{product.id}") do
        click_link(product.title)
      end
      page.should have_content(product.title)
      page.should have_content(product.description)
      page.should have_content(product.price)
      page.should have_selector("img#product_image")
    end

  end
end