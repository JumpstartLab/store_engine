require 'spec_helper'

describe Product do
  let!(:products) do
    [Fabricate(:product), Fabricate(:product), Fabricate(:product)]
  end

  before(:each) do
    visit "/products"
  end

  context "index" do
    it "shows all of the product titles" do
      products.each do |product|
        page.should have_content(product.title)
      end
    end

    it "shows all of the product prices" do
      products.each do |product|
        page.should have_content(product.price)
      end
    end 

    it "links to product page from product title" do
    end 
  end
end