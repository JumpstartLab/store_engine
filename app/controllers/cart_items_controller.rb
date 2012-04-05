class CartItemsController < ApplicationController

  def create
    if existing_item = current_cart.cart_items.find_by_product_id(params[:product_id])
      existing_item.update_attributes(quantity: existing_item.quantity + 1)
    else
      current_cart.cart_items.create!(product_id: params[:product_id], quantity: 1)
    end
    flash[:notice] = "Item added to cart!"
    redirect_to (request.referer)
  end
end
