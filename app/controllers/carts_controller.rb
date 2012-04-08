class CartsController < ApplicationController
  # before_filter :find_or_create_cart_from_session

  def show
  end

  def update
    case params[:cart_action]
    when "add"
      @cart.add_product_by_id(params[:product_id])
    when "remove"
      @cart.remove_product_by_id(params[:product_id])
    end
    session[:cart_id] = @cart.id
    redirect_to cart_path
  end

end
