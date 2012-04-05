class CartsController < ApplicationController
  before_filter :find_or_create_cart_from_session

  def show
  end

  def update
    @cart.add_product_by_id(params[:product_id])
    redirect_to cart_path
  end

  def find_or_create_cart_from_session
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    @cart
  end
end
