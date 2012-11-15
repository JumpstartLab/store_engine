require 'spec_helper'

describe "Using the shopping cart" do
  
  context "when I'm on the cart page" do
    before(:each) { visit cart_path }

    context "and I haven't added any products" do
      it "should notify customer that there is nothing in the cart" do
        within("#cart") do
          page.should have_content("no items")
        end
      end
    end
  end

  context "when I'm on a product page" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) { visit product_path(product) }

    context "and I click 'add to cart'" do
      before(:each) { click_link("Add to cart") }

      it "takes me to the cart page" do
        page.should have_content("Your Cart")
      end

      it "shows the product in my cart" do
        # save_and_open_page
        within("#cart") do
          page.should have_content(product.name)
        end
      end

      it "shows a product quantity" do
        within("#cart") do
          page.should have_selector("input#quantity_product_#{product.id}", :value => 1)
        end
      end

      it "updates the cart count in the header" do
        within("li#cart-menu") do
          page.should have_content("1")
        end
      end

      it "shows the subtotal" do
        within("#cart") do
          page.should have_content(product.price)
        end
      end

      context "when I try to remove a product" do
        before(:each) { click_link_or_button("Remove from cart") }

        it "does not have any products in the cart" do
          within("#cart") do
            page.should_not have_content(product.name)
          end
        end
      end

      context "when I add multiple items to the cart" do
        before(:each) do
          visit product_path(product)
          click_link_or_button("Add to cart" )
        end

        it "shows an increased product quantity" do
          within("#cart") do
            page.should have_selector("input#quantity_product_#{product.id}", :value => 2)
          end
        end

        it "updates the cart count in the header" do
          within("li#cart-menu") do
            page.should have_content("2")
          end
        end

        it "shows the original price" do
          within("#cart") do
            page.should have_content("")
          end
        end
      end

      context "when I remove items from my cart" do
        before(:each) do
          visit cart_path
          click_link_or_button("Remove from cart")
        end

        it "shows a decreased product quantity" do
          within("#cart") do
            page.should_not have_content(product.name)
          end
        end

        it "updates the cart count in the header" do
          within("li#cart-menu") do
            page.should have_content("0")
          end
        end

        it "should notify customer that there is nothing in the cart" do
          within("#cart") do
            page.should have_content("no items")
          end
        end
      end
    end
  end

  context "when I have products in my cart" do
    let(:product) { FactoryGirl.create(:product) }
    before(:each) do
      visit product_path(product)
      click_link("Add to cart")
    end

    context "and I log in as a user" do
        let(:user) { FactoryGirl.create(:user) }
        attrs = FactoryGirl.attributes_for(:user)

        before do
          visit signin_path
          fill_in "email",    with: user.email
          fill_in "password", with: attrs[:password]
          click_button "Log in"
        end

        it "does not change the cart counter in the header" do
          within("li#cart-menu") do
            page.should have_content("1")
          end
        end

        context "and I go to the product page" do
          before(:each) do
            visit cart_path
          end

          it "should not clear the cart" do
            within("#cart") do
              page.should have_content(product.name)
            end
          end
        end

        context "and I log out" do
          before(:each) do
            click_link_or_button(user.name)
            click_link_or_button("Sign out")
          end

          it "should clear my cart" do
            within("li#cart-menu") do
              page.should have_content("0")
            end
          end

          context "and I go to the product page" do
          before(:each) do
            visit cart_path
          end

          it "should clear my cart" do
            within("#cart") do
              page.should_not have_content(product.name)
            end
          end

          context "and I re-log back in" do
            before do
              visit signin_path
              fill_in "email",    with: user.email
              fill_in "password", with: attrs[:password]
              click_button "Log in"
            end

            it "should preserve the number of my products" do
              within("li#cart-menu") do
                page.should have_content("1")
              end
            end

            context "and I go to the product page" do
              before(:each) do
                visit cart_path
              end

              it "should not have cleared the cart" do
                within("#cart") do
                  page.should have_content(product.name)
                end
              end
            end
          end
        end
      end
    end

    context "and I'm on the cart page" do
      before(:each) { visit cart_path }

      context "when I try to update the quantity of a product" do
        before(:each) do
          fill_in "quantity_product_#{product.id}",         with: "10"
          click_button("update")
        end

        it "should update the quantity of the product" do
          page.should have_selector("input#quantity_product_#{product.id}", :value => 10)
        end

        it "should update the cart counter in my header" do
          within("li#cart-menu") do
            page.should have_content("10")
          end
        end

        it "should update the cart total" do
          within("#total-row") do
            page.should have_content(product.price * 10)
          end
        end
      end

      context "when I try to update the quantity of a product to 0" do
        it "should delete the product from my cart" do
          fill_in "quantity_product_#{product.id}",         with: "0"
          click_button("update")
          page.should_not have_selector("input#quantity_product_#{product.id}")
          page.should_not have_content(product.name)
        end
      end

    end
  end
end