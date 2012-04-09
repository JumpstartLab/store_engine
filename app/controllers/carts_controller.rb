class CartsController < ApplicationController
  before_filter :lookup_cart_from_session

  def show

  end

  def update
    @cart = Cart.create unless session[:cart_id]
    @cart.add_product_by_id(params[:product_id])
    session[:cart_id] = @cart.id
    redirect_to cart_path
  end

  def delete_product
    @cart.remove_product_by_id(params[:product_id])
    session[:cart_id] = @cart.id
    redirect_to cart_path
  end


  private

  def lookup_cart_from_session
    if current_user
      session[:cart_id] = current_user.cart.id
      @cart = Cart.find_by_id(session[:cart_id])
    elsif session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    else
      @cart = Cart.new
    end
  end
end
