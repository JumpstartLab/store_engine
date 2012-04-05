class CartsController < ApplicationController
  # before_filter :find_or_create_cart_from_session

  def show
    find_or_create_cart_from_session
  end

  def update
    @cart = find_or_create_cart_from_session
    @cart.add_product_by_id(params[:product_id])
    session[:cart_id] = @cart.id
    # raise @cart.products.inspect
    redirect_to cart_path
    # render :show
  end

  private

  def find_or_create_cart_from_session
    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    end
    @cart ||= Cart.create
  end
end
