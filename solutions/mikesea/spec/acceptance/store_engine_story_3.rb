require 'spec_helper'

feature "Admin Puts Product Through Lifecycle" do
  before(:all) do
    Seeder.build_db
  end

  after(:all) do
    Seeder.destroy_db
  end

  #Given I am logged in as "demoXX+chad@jumpstartlab.com and am viewing admin area of store"
  before(:each) do
    login_user_post("demo08+chad@jumpstartlab.com", "hungry")
    visit admin_dashboard_path
  end

  context "When I create a product" do
    #Given I click the add product link/button
    before(:each) { click_link("Add a product") }
    let(:prod_name) { "The Bill Clinton" }
    let(:prod_descrip) { "A shirt that is forever in style" }
    let(:prod_price) { "25.17" }
    let(:prod_photo) { "http://image.spreadshirt.com/image-server/image/composition/15110546/view/1/producttypecolor/187/type/png/width/280/height/280/cool-democrat_design.png" }

    context "And I fill in the fields with valid information" do
      before do
        fill_in "product_name", with: prod_name
        fill_in "product_description", with: prod_descrip
        fill_in "product_price", with: prod_price
        fill_in "product_photo", with: prod_photo
      end

      context "When I click the create product link/button" do
        before { click_link_or_button("Create Product") }

        it "then I should see the created product" do
          uri = URI.parse(current_url)
          "#{uri.path}".should == admin_product_path(Product.last.id)
        end

        it "then I should see the correct product info" do
          page.should have_content( prod_name )
          page.should have_content( prod_descrip )
          page.should have_content( prod_price )
          page.should have_xpath("//img[@src=\"#{prod_photo}\"]")
        end

        context "When I create a category" do
          before do
            visit admin_dashboard_path
            click_link_or_button "Create a category"
          end

          context "And I fill in the field with a new category name" do
            before do
              fill_in "category_name", with: "Knives"
              click_link_or_button "Create Category"
            end

            it "then I should see the new category" do
              page.should have_link( "Knives" )
            end

            context "When I add a product to the category" do
              before { click_link(prod_name) }
                
              context "When I edit the product" do
                before do
                  click_link("Edit this product")
                  check("category_knives")
                  click_link_or_button("Update Product")
                end

                context "When I browse to the category" do
                  before do 
                    visit admin_dashboard_path
                    click_link_or_button("Knives")
                  end

                  it "then I should see the product" do
                    page.should have_content(prod_name)
                    page.should have_xpath("//img[@src=\"#{prod_photo}\"]")
                  end

                  context "When I retire a product" do
                    #Given I am editing a product that has been purchased by demo08+matt@jumpstartlab.com
                    let(:user) { User.find_by_email("demo08+matt@jumpstartlab.com") }
                    let(:product) { user.orders.first.products.first }
                    before do
                      visit admin_order_path(user.orders.first)
                      click_link_or_button(product.name)
                      click_link_or_button("Retire product")
                    end

                    context "When I log out" do
                      it "then I should not see the product" do
                        before { visit root_path }

                        page.should_not have_content(product.name)
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
end