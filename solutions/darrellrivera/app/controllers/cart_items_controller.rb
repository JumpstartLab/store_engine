class CartItemsController < ApplicationController
  def destroy
    cart = Cart.find(session[:cart_id])
    item = OrderItem.find(params[:item_id])
    item.destroy
    redirect_to cart_path
  end
end
