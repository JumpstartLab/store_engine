class OrdersController < ApplicationController
  before_filter :signed_in_user
  before_filter :shipping_information, only: [:new, :edit, :update]
  before_filter :billing_information, only: [:new, :edit, :update]

  def index
    @orders = current_user.orders.order(params[:sort])
  end

  def new
    @order = Order.new
    @cart = Cart.find(params[:cart_id])
  end

  def edit
  end

  def update
    order.update_attributes(params[:order])
    redirect_to order_path(order)
  end

  def create
    order = Order.create_order_from_cart(cart, current_user)
    order.paid?(current_user, order)
    cart.destroy
    redirect_to order_path(order)
  end

  helper_method :order

  private

  def order
    @order ||= Order.find(params[:id])
  end

  def shipping_information
    store_order_location
    if current_user.shipping_information.nil?
      redirect_to new_shipping_information_path
    else
      @shipping_information ||= current_user.shipping_information
    end
  end

  def billing_information
    store_order_location
    if current_user.billing_information.nil?
      redirect_to new_billing_information_path 
    else
      @billing_information ||= current_user.billing_information
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

end
