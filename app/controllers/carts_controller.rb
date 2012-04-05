class CartsController < ApplicationController
  def show
    @cart = Cart.new
  end

  def update
    @cart.add_product_by_id(params[:product_id])
    redirect_to cart_path
  end
end
