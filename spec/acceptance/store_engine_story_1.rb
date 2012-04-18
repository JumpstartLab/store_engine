require 'spec_helper'

# Anonymous Shopper Makes a Purchase

feature "Checking Out While Logged Out" do

  before(:all) do
    Seeder.build_db
  end

  after(:all) do
    Seeder.destroy_db
  end

  #Given I am not logged in
  before(:each) do
    visit signout_path
  end
  
  context "When I view the home page" do
    before(:each) do
      visit root_path
    end
    
    it "then I should see a list of products" do
      within "ul.thumbnails" do
        page.should have_selector( "li.span4", :count => Product.count )
      end
    end

    context "When I am viewing details for a product" do
      before(:each) do
        click_link_or_button(Product.first.name)
      end
      
      it "then I should see the product details" do
        page.should have_content( "Description" )
        page.should have_content( "Categories" )
        page.should have_content( "Price" )
        page.should have_content( Product.first.name )
      end

      it "then I should see 'add to cart'" do
        page.should have_link( "add_to_cart_#{Product.first.id}" )
      end

      context "When I click 'add to cart'" do
        before(:each) do
          click_link_or_button( "add_to_cart_#{Product.first.id}" )
        end

        it "then I should see my cart" do
          uri = URI.parse(current_url)
          "#{uri.path}".should == cart_path
          page.should have_content("Quantity")
          page.should have_content("Checkout")
          page.should have_content("Total")
        end

        it "then my cart should show the product with quantity 1" do

        end

        it "then my cart total should be correct" do
          within "#total-row" do
            page.should have_content(Product.first.price)
          end
        end

        context "When I check out" do
          before(:each) do
            click_link("go_checkout")
          end

          it "then I should be asked to login" do
            uri = URI.parse(current_url)
            "#{uri.path}".should == signin_path
          end

          context "When I log in" do
            before(:each) do
              fill_in "email",    with: User.first.email
              fill_in "password", with: "hungry"
              click_link_or_button("go_log_in")
            end

            it "then I should be purchasing with quantity 1" do
              save_and_open_page
            end
          end
        end
      end
    end
  end
end