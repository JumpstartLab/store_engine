class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def show
    session[:return_to] = request.fullpath
  end

  def update
    session[:cart] = current_cart.update(params[:carts])
    redirect_to(:back)
  end

  def remove_item
    session[:cart] = current_cart.remove_item(params[:remove_item])
    redirect_to(:back)
  end

  def destroy
    session[:cart] = current_cart.destroy
    redirect_to root_path, :notice  => "Cart cleared."
  end
end
