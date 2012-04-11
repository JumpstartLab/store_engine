require 'spec_helper'

describe Product do
  let!(:products) do
    [
      Fabricate(:product), 
      Fabricate(:product), 
      Fabricate(:product)
    ]
  end
  let(:product) { Fabricate(:product) }
  let(:category) { Fabricate(:category) }

  context "index" do
    before(:each) do
      visit products_path
    end

    it "shows all of the product titles" do
      products.each do |product|
        page.should have_content(product.title)
      end
    end

    # it "shows all of the product prices" do
    #   products.each do |product|
    #     page.should have_content(product.price)
    #   end
    # end 

    it "has links to show each product" do
      products.each do |product|
        find_link("#{product.title}")
      end
    end
  end

  context "show" do
    before(:each) do
      product.add_category(category)
      visit product_path(product)
    end

    it "adds a product to the cart when 'add to cart' is clicked" do
      click_link "Add to Cart"
      page.should have_content(product.title)
    end

    it "lists all the product's categories" do
      page.should have_content(category.name)
    end
  end
end