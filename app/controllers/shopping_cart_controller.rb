class ShoppingCartController < ApplicationController

  def show
    @cart_items = cart.cart_items
  end

  def update
    cart.update_quantities(params[:quantity])
    render shopping_cart_path
  end
end
