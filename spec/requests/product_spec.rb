require 'spec_helper'

describe "Updating products" do
  context "when I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit product_path(product)}

    context "and I click 'New Product'" do
      before(:each) { click_link("New Product")}

      it "takes me to the new product page" do
        page.should have_content('New product')
      end
    end

    context "and I click 'Edit this product'" do
      before(:each) { click_link("Edit this product") }

      it "takes me a product's edit page" do
        page.should have_content("Edit this product")
      end

      context "and I update the product" do
        before(:each) { click_button("Update Product") }
        it "takes me back to the product's detail page" do
          page.should have_content(product.name)
        end

        it "lets me know the product was updated" do
          page.should have_content("Product was successfully updated.")
        end
      end

      context "and I click 'Back'" do
        before(:each) { click_link("Back")}

        it "takes me back to the list of products" do
          page.should have_content("Products")
        end
      end
    end
  end
end