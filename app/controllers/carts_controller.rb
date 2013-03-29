class CartsController < ApplicationController
  before_filter :find_or_create_cart

  def show
    session[:return_to] = request.fullpath
    cart = session[:cart].map { |id, quantity| [Product.find(id), quantity] }
    @cart = Hash[cart]
  end

  def update
    if params[:delete]
      session[:cart].delete(params[:delete].to_s)
    elsif id = params[:carts][:product_id]
      quantity = params[:carts][:quantity]
      session[:cart][id] = quantity || (session[:cart][id].to_i + 1).to_s
    end
    redirect_to :back, :notice  => "Updated"
  end

  def destroy
    session[:cart] = {}
    redirect_to root_path, :notice  => "Cart cleared."
  end
end
