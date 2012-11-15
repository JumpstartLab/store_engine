class CartsController < ApplicationController
  before_filter :find_or_create_cart_from_session
  before_filter :require_login, :only => :checkout

  def show
  end

  def update
    if params[:cart] && params[:cart][:order_item]
      item = OrderItem.find(params[:cart][:order_item][:id])
      item.update_attributes(params[:cart][:order_item])
    else
      @cart.add_product_by_id(params[:product_id])
    end
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

  def checkout
    order = Order.create_from_cart(@cart)
    order.update_attributes(:user_id => current_user.id)
    redirect_to billing_path(:order_id => order.id)
  end
end
