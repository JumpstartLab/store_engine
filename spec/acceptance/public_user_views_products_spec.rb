require 'spec_helper'

describe "Public User Views Products" do
  context "the root page" do
    before(:each) do
      visit root_path
    end

    it "displays products" do
      within("#products") do
        page.should have_selector('li.product')
      end
    end

    it "has product links" do
      p = Product.first
      within("#products") do
        page.should have_link(p.to_s, :href => product_path(p))
      end
    end
  end

  context "the product page" do
    let(:product){ Product.first }

    before(:each) do
      visit product_path(product)
    end

    it "displays the product name" do
      page.should have_selector("#name", :text => product.to_s )
    end
  end
  
end