class CartItemsController < ApplicationController
  def create
    cart.add_or_increment_by_product_id(params[:product_id])
    redirect_to cart_path
  end
end
