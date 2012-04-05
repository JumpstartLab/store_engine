class CartsController < ApplicationController
  before_filter :lookup_cart_from_session

  def show
  end

  def update
    @cart = Cart.create
    @cart.add_product_by_id(params[:product_id])
    session[:cart_id] = @cart.id
    redirect_to cart_path
  end

  private

  def lookup_cart_from_session
    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    end
    @cart ||= Cart.new
  end
end
