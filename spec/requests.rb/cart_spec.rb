require 'spec_helper'

describe "Using the shopping cart" do
  
  context "When I'm on a product page" do
    let(:product) {FactoryGirl.create(:product)}
    
    before(:each) { visit product_path(product) }
    
    context "When I click 'add to cart'" do
      before(:each) { click_link_or_button "add to cart" }
      
      it "takes me to the cart page" do
        page.should have_content("Your Cart")
      end

      it "shows the product in my cart" do
        save_and_open_page
        within("#cart") do
          page.should have_content(product.title)
        end
      end
      
      # it "shows the cart quantity" do
      # end
      
      # it "shows the cart total" do
      # end
    end
  end
end