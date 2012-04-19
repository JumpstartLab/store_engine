require 'spec_helper'

feature "Shopper Does Bad Things" do
  before(:all) do
    Seeder.build_db
  end

  after(:all) do
    Seeder.destroy_db
  end

  #Given I am logged in as "demoXX+chad@jumpstartlab.com and am viewing admin area of store"
  before(:each) do
    login_user_post("demo08+matt@jumpstartlab.com", "hungry")
    visit root_path
  end

  let(:user) { User.find_by_email("demo08+matt@jumpstartlab.com") }
  let(:order_product) { user.orders.first.order_products.first }

  context "After a product is retired" do
    before do
      order_product.product.update_attribute(:retired, 'true')
    end

    context "When I am viewing previous orders" do
      before do
        visit orders_path
        click_link_or_button("Order ##{order_product.order.id}")
      end

      context "When I view the product" do
        before do
          click_link_or_button(order_product.name)
          @previous_uri = URI.parse(current_url)
          save_and_open_page
          click_link_or_button("Add to cart")
        end

        it "then I should see it is retired" do
          uri = URI.parse(current_url)
          "#{uri.path}".should == @previous_uri.path
        end

        context "When I add it to my cart" do
          it "then I should be told I can't add it to my cart" do

          end

          it "then it should not appear in my cart" do

          end

          context "When I log out" do        
            context "When I try to view a previous order" do
              it "then I should see a 404 or other error message" do

              end
            end
          end        
        end
      end
    end
  end
end
