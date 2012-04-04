require 'spec_helper'

describe ShoppingCartController do

  describe "GET show" do
    it "gets all cart items" do
      cart = mock("shopping_cart")
      ShoppingCart.stub(:find).and_return(cart)

      cart_item = double("cart_item")
      cart_item2 = double("cart_item")
      cart.stub(:cart_items).and_return([cart_item, cart_item2])

      get :show
      assigns(:cart_items).should eq([cart_item, cart_item2])
    end
  end
end
