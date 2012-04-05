require 'spec_helper'

# describe "Using the shopping cart", :focus => true do
#   context "when I'm on a product page" do
#     let(:product) { FactoryGirl.create(:product) }
#     before(:each) do 
#       visit product_path(product)
#     end

#     context "and I click 'add to cart'" do
#       before(:each) do 
#         click_link("Add to cart")
#       end

#       it "takes me to the cart page" do
#         page.should have_content("Your Cart")
#       end

#       it "shows the product in my cart" do
#         # save_and_open_page
#         within("#cart") do
#           page.should have_content(product.title)
#         end
#       end
#       it "shows the cart quantity" do
#       end
#       it "shows the cart total" do
#       end
#     end

#   end
# end

describe "test shopping cart", :focus => true do
  let(:product) { FactoryGirl.create(:product) }
  let(:cart)    { FactoryGirl.create(:cart) }

  it "opens page" do
    cart.add_product(product)
    visit cart_path
    save_and_open_page
  end
end