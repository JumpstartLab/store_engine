require 'spec_helper'

describe "As an admin updating products" do

  let!(:user) { FactoryGirl.create(:user, :admin => true) }

  before(:each) do
    login_user_post(user.email, "foobar")
  end
  
  context "when I'm on the products index page"
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit admin_products_path }

    context "and I click 'New Product'" do
      before(:each) { click_link("New Product")}

      it "takes me to the new product page" do
        page.should have_content('New product')
      end

      context "and I enter invalid information" do

        it "does not create a new product" do
          expect {click_link_or_button('Create Product')}.to_not change(Product, :count).by(1)
        end

        it "shows me some error message" do
          click_link_or_button('Create Product')
          page.should have_selector('div.alert.alert-error')
        end
      end

      context "and I enter valid information" do
        let(:new_product) { FactoryGirl.build(:product) }

        before do
          fill_in "Name", with: new_product.name
          fill_in "Description", with: new_product.description
          fill_in "product_price", with: new_product.price
        end

        it "successfully creates a product" do
          expect {click_link_or_button('Create Product')}.to change(Product, :count).by(1)
        end
      end
    end

    context "and I retire a product" do
      before(:each) { visit admin_product_path(product) }

      it "retires that product" do
        click_link_or_button('Retire product')
        Product.find(product.id).retired.should == true
      end

      context "and I want to un-retire that product" do
        before do  
          visit admin_product_path(product)
          click_link_or_button('Retire product')
        end

        it "un-retires that product" do
          save_and_open_page
          visit admin_products_path
          click_link_or_button('Un-retire')
          Product.find(product.id).active?.should == true
        end
      end
    end

  context "when I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit admin_product_path(product)}

    context "and I click 'Edit this product'" do
      before(:each) { click_link("Edit this product") }

      it "takes me a product's edit page" do
        page.should have_content("Edit")
        page.should have_button("Update Product")
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