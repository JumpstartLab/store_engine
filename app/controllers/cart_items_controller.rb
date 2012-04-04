class CartItemsController < ApplicationController

  def create
    current_cart.cart_items.create!(product_id: params[:product_id], quantity: 1)
    flash[:notice] = "Item added to cart!"
    redirect_to (request.referer)
  end
end
