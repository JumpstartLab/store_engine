class CartItemsController < ApplicationController
  def create
    cart.add_or_increment_by_product_id(params[:product_id])
    redirect_to cart_path
  end

  def update
    cart_item = CartItem.find_by_id(params[:id])
    cart_item.update_attributes(params[:cart_item])
    redirect_to cart_path
  end

  def destroy
    cart_item = CartItem.find_by_id(params[:id])
    cart_item.destroy
    redirect_to cart_path
  end
end
