class ShoppingCartController < ApplicationController

  def show
    cart = current_user.shopping_cart
    @cart_items = cart.cart_items
  end

  def update
    cart.add_item(params[:product], params[:cart_item][:quantity])
    redirect_to shopping_cart_path
  end
end
