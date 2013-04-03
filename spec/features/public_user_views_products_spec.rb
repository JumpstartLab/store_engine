require 'spec_helper'

feature "Public User Views Products" do

  context "the root page" do
    before(:each) do
      @product = FactoryGirl.create(:product)
      visit root_path
    end

    it "displays products" do
        page.should have_content(@product.description)
    end
  end

  context "the product page" do
    before(:each) do
      @product = FactoryGirl.create(:product)
      visit product_path(@product)
    end

    it "displays the product name" do
      page.should have_content @product.title
    end

    it "has an add-to-cart action" do
      click_button "Add to Cart"
      expect(current_path).to eq product_path(@product)
    end
  end
end
