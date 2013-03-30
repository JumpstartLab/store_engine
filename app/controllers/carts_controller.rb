class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def show
    session[:return_to] = request.fullpath
    @cart = Cart.new(session[:cart]).representation
  end

  def update
    session[:cart] = Cart.new(session[:cart]).update(params[:carts])
    redirect_to(:back)
  end

  def remove_item
    session[:cart] = Cart.new(session[:cart]).remove_item(params[:remove_item])
    redirect_to(:back)
  end

  def destroy
    session[:cart] = {}
    redirect_to root_path, :notice  => "Cart cleared."
  end
end
