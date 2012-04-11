require 'spec_helper'

describe Cart do
  let(:product) { Fabricate(:product) }
  let(:cart) { Fabricate(:cart) }
  let(:category) { Fabricate(:category) }
  let(:user) { Fabricate(:user) }

  context "as an authenticated user" do
    context "when I click checkout with a product in my cart" do
      before(:each) do
        cart.add_product(product)
        login_as(user)
        visit cart_path
      end

      it "takes me to a billing page" do
        click_link "Checkout"
        page.should have_content("Billing Information")  
      end

      it "creates a pending order" do
        count = Order.find_all_by_status("pending").count
        expect {
          click_link "Checkout"  
        }.to change{ Order.find_all_by_status("pending").count }.by(1)
      end

      context "and I submit new billing information" do
        before(:each) do
          cart.add_product(product)
          login_as(user)
          visit cart_path
          click_link "Checkout"
        end

        it "creates a credit card" do
          fill_billing_form
          expect {
            click_button "Submit" 
          }.to change{ CreditCard.count }.by(1)
        end

        it "creates an address" do
          fill_billing_form
          expect {
            click_button "Submit" 
          }.to change{ Address.count }.by(1)
        end
      end
    end
  end

  context "when a user clicks on 'add to cart'" do
    before(:each) do
      visit product_path(product)
      click_link "Add to Cart"
    end

    it "adds the product to the cart" do
      visit cart_path
      within ("#cart") do
        page.should have_content(product.title)
      end
    end
  end 

  context "is linked from" do
    it "the products page" do
      visit products_path
      page.should have_content("View Cart")
    end

    it "a product page" do
      visit product_path(product)
      page.should have_content("View Cart")
    end

    it "a category page" do
      visit category_path(category)
      page.should have_content("View Cart")
    end
  end

  context "can be visited by clicking 'View Cart' from" do
    it "the products page" do
      visit products_path
      click_link "View Cart"
      page.should have_content("Your Cart")
    end

    it "a product page" do
      visit product_path(product)
      click_link "View Cart"
      page.should have_content("Your Cart")
    end

    it "a category page" do
      visit category_path(category)
      click_link "View Cart"
      page.should have_content("Your Cart")
    end
  end

  context "when I click on remove" do
    before(:each) do
      visit product_path(product)
      click_link "Add to Cart"
      click_link "Remove"
    end

    it "removes the product from my cart" do
      page.should_not have_content(product.title)
    end
  end
end