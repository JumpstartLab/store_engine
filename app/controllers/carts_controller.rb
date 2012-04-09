class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def update
    @cart = Cart.create
    @cart.add_product_by_id(params[:product_id])
    session[:cart_id] = @cart.id
    redirect_to cart_path
  end

  private
end
