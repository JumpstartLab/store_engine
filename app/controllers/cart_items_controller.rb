class CartItemsController < ApplicationController

  def destroy
    cart.remove_item(params[:id])
    redirect_to shopping_cart_path
  end

end


