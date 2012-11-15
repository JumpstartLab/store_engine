class CartItemsController < ApplicationController

  def create
    cart.add_item(params[:product], params[:cart_item][:quantity])
    redirect_to shopping_cart_path
  end

  def destroy
    cart.remove_item(params[:id])
    redirect_to shopping_cart_path
  end
end


