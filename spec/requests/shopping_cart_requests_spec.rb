require 'spec_helper'

describe "Shopping Cart Requests" do
  context "GET show action" do
    let!(:user) { Fabricate(:user) }
    let!(:cart_item) do
      Fabricate(:cart_item, :product => Fabricate(:product, :title => "iPod"))
    end

    before(:each) do
    end

     it "list the current cart items" do
      login_user_post("admin", "admin")
      visit '/shopping_cart'
       #find_link("iPod").visible? 

       # when I click on add to cart it creates a new cart item
      # the new cart item should be visible in my cart
      # the number of items in my cart should increase
     end

  end
end
