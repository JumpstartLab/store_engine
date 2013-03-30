class OrdersController < ApplicationController
  before_filter :require_login

  def new
    @order = Order.new
  end

  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    order = Order.find(params[:id])
    if current_user.id == order.user_id
      @order = Order.find(params[:id])
    else
      redirect_to account_orders_path
    end
  end

  def create
    @order = Order.create_and_charge(cart: current_cart,
                                     user: current_user,
                                     token: params[:stripeToken])
    if @order.valid?
      session[:cart] = current_cart.destroy
      redirect_to user_order_path(current_user, @order), :notice => "Successfully created order!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end

  def buy_now
    @order = Order.create_and_charge(cart: Cart.new({params[:order] => '1'}),
                                     user: current_user,
                                     token: params[:stripeToken])
    if @order.valid?
      session[:cart] = current_cart.destroy
      redirect_to user_order_path(current_user, @order), :notice => "Successfully created order!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end
end
