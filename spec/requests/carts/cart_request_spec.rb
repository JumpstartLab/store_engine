require 'spec_helper'

describe "Using the shopping cart" do
  let(:cart)      { Cart.create }
  let(:product)   { Fabricate(:product)}
  let(:new_product) { Fabricate(:product) }
  let(:products)  {[product, new_product]}
  let(:user)      { Fabricate(:user, :password => 'password',
                                     :admin => 'false')}
  let(:admin_user)      { Fabricate(:user, :password => 'password',
                                    :admin => 'true')}


  context "when adding products to the cart" do

    context "and I'm on a product page" do
      before(:each) do
        visit product_path(product)
      end

      context "and I click 'add to cart'" do
        before(:each) do
          click_link_or_button "add to cart"
        end
    
        it "takes me to my cart" do
          page.should have_content("Your Cart")
        end

        it "shows the product in my cart" do
          within("#cart") do
            page.should have_content(product.title)
          end
        end

        it "links back to product index" do
          page.should have_link("", :href => products_path)
        end
      end
    end

    it "persists the cart for adding multiple items" do
      visit product_path(product)
      click_link_or_button "add to cart"
      visit product_path(new_product)
      click_link_or_button "add to cart"
      within "#cart" do
        products.each do |product|
          page.should have_content(product.title)
        end
      end
    end
  end

  context "when removing products from the cart" do
    context "when the cart contains a product" do
      before(:each) do
        visit product_path(product)
        click_link_or_button "add to cart"
      end

      it "shows a link to remove the product" do
        within("#cart") do
          page.should have_link("remove")
        end
      end

      it "returns me to the cart after removing" do
        within ".cart-product" do
          click_link_or_button "remove"
        end
        page.should have_content("Your Cart")
      end

      it "removes the product from the cart" do
        click_link_or_button "remove"
        within "#cart" do
          page.should_not have_content(product.title)
        end
      end
    end
  end

  context "when returning to a user cart" do
    before(:each) do
      login(user)
    end
    context "and the user adds something to the cart" do
      before (:each) do
        visit product_path(product)
        click_link_or_button "add to cart"
        visit "/logout"
      end

      it "finds the same cart after logout" do
        login(user)
        visit product_path(new_product)
        click_link_or_button "add to cart"

        within ".table" do
          products.each do |product|
            page.should have_content(product.title)
          end
        end
      end
    end
  end

  context "when logging in after adding a product to the cart" do
    before (:each) do
      visit product_path(product)
      click_link_or_button "add to cart"
    end
    it "keeps the product in the users cart after login" do
      login(user)
      visit "/cart"

      page.should have_content(product.title)
    end

    it "increments the quantity when adding the same product multiple times" do
      visit product_path(product)
      click_link_or_button "add to cart"
      visit product_path(product)
      click_link_or_button "add to cart"

      login(user)
      visit "/cart"
      page.should have_content(product.title)

      user.cart.cart_products.last.quantity.should == 3
      user.cart.cart_products.count.should == 1
    end
  end

  context "when viewing the cart" do

    before (:each) do
      visit product_path(product)
      click_link_or_button "add to cart"
      visit product_path(new_product)
      click_link_or_button "add to cart"
    end

    it "shows the total" do
      page.should have_selector("#total")
    end

    it "shows the subtotals for each product" do
      within ".cart-product" do
        page.should have_selector(".subtotal")
      end
    end

    it "has a field for setting quantity" do
      within ".cart-product" do
        page.should have_selector(".edit_cart_product")
      end
    end
  end

  context "when a product gets retired" do
    before (:each) do
      login(user)
      visit product_path(product)
      click_link_or_button "add to cart"
      visit logout_path
      login(admin_user)

      visit admin_products_path
      within("tr#product_#{product.id}") do
        click_link_or_button("Retire")
      end
      visit logout_path
      login(user)
      visit "/cart"
    end

    it "removes the product from the cart" do
      page.should_not have_content(product.title)
    end

  end
end








