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

        it "creates a paid order" do
          fill_billing_form
          expect {
            click_button "Submit"
          }.to change{ Order.find_all_by_status("paid").count }.by(1)
        end

        it "redirects me to see my order" do
          fill_billing_form
          click_button "Submit"
          page.should have_content("Thank you!")
          find('h1').should have_content("Order")
        end

        it "clears my cart" do
          fill_billing_form
          click_button "Submit"
          visit cart_path
          page.should have_content("Your Cart is Empty.")
        end

        context "paid order" do
          before(:each) do
            fill_billing_form
            click_button "Submit"
          end

          it "shows the status as paid" do
            page.should have_content("paid")
          end

          it "shows me the order total" do
            page.should have_content(user.orders.last.total)
          end
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

    it "shows the correct total in the cart" do
      find('#total').should have_content(product.price)
    end
  end

  context "when an authenticated user clicks on 'add to cart'" do
    before(:each) do
      login_as(user)
      visit product_path(product)
      click_link "Add to Cart"
    end

    it "adds the product to the cart" do
      visit cart_path
      within ("#cart") do
        page.should have_content(product.title)
      end
    end

    it "shows the correct total in the cart" do
      find('#total').should have_content(product.price)
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

  context "when I increase the quantity of a product and click update cart" do
    before(:each) do
      visit product_path(product)
      click_link "Add to Cart"
      fill_in "cart_order_item_quantity", :with => "2"
      @previous_total = find("#total").text.to_f
      @previous_subtotal = find(".subtotal").text.to_f
      click_button "Update Cart"
    end

    it "changes the quantity in the cart" do
      find("#cart_order_item_quantity").value.should == "2"
    end

    it "increases the subtotal for that product" do
      find(".subtotal").text.to_f.should > @previous_subtotal
    end

    it "increases the total of the cart" do
      find("#total").text.to_f.should > @previous_total
    end
  end
end
