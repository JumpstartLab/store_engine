require 'spec_helper'

describe ShoppingCartController do

  describe "GET show" do
    get :show
    assigns(:cart_items).should eq([""])
     #cart = mock("shopping_cart")
    # ShoppingCart.stub(:find).and_return(cart)

    # cart_item = double("cart_item")
    # cart_item2 = double("cart_item")
    # cart.stub(:cart_items).and_return([cart_item, cart_item2])

    # controller = ShoppingCartController.new 
    # controller.show.should == [cart_item, cart_item2]
  end

end
