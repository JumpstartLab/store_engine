require 'spec_helper'

feature "Adding Products To The Cart From Multiple Sources" do
  let(:user) { User.find_by_email("demo08+matt@jumpstartlab.com") }

  before(:all) do
    Seeder.build_db
  end

  after(:all) do
    Seeder.destroy_db
  end

  #Given I am logged in as "demoXX+matt@jumpstartlab.com"
  before(:each) do
    login_user_post("demo08+matt@jumpstartlab.com", "hungry")
  end
  
  context "When I have previously purchased a product" do
    before(:each) do
      visit root_path
      click_link_or_button("#{Category.first.name}")
    end
    
    context "When I view the products in the category" do
      it "then I should see a list of products all in the category" do
        within "ul.thumbnails" do
          page.should have_selector( "li.span4", :count => Category.first.products.count )
        end
      end

      context "When I am viewing details for a product" do
        let(:target_product) { Category.first.products.first }

        before(:each) do
          click_link_or_button(target_product.name)
        end

        it "then I should be on the product details page" do
          uri = URI.parse(current_url)
          "#{uri.path}".should == product_path(target_product.id)
        end

        it "then I should see the product details" do
          page.should have_content( "Description" )
          page.should have_content( "Categories" )
          page.should have_content( "Price" )
          page.should have_content( target_product.name )
        end

        it "then I should see 'add to cart'" do
          page.should have_link( "add_to_cart_#{target_product.id}" )
        end

        context "When I am adding a product to cart" do
          #Given I am viewing the product from a category page
          before do 
            visit root_path
            click_link_or_button("#{Category.first.name}")
          end

          context "When I click 'add to cart'" do
            before { click_link_or_button("add_to_cart_#{target_product.id}") }

            it "then I should see my cart" do
              uri = URI.parse(current_url)
              "#{uri.path}".should == cart_path
              page.should have_content("Quantity")
              page.should have_content("Checkout")
              page.should have_content("Total")
            end

            it "then my cart should show the product with quantity 1" do
              page.has_field?("quantity_product_#{ target_product.id }", :with => "1")
            end

            context "When I am viewing previous orders" do
              before { visit orders_path }

              context "And I choose the order containing a product" do
                let( :target_order_product ) { user.orders.first.products.first }
                before { click_link("Order ##{user.orders.first.id}") }
              
                context "And I view the product" do
                  before { click_link("#{target_order_product.name}")}

                  context "And I add it to my cart" do
                    before { click_link("add_to_cart_#{target_order_product.id}") }

                    it "then my cart should show the existing product with quantity 1" do
                      page.has_field?("quantity_product_#{ target_product.id }", :with => "1")
                    end

                    it "then my cart should contain the previously purchased product with quantity 1" do
                      page.has_field?("quantity_product_#{ target_order_product.id }", :with => "1")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end