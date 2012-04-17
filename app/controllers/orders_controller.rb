class OrdersController < ApplicationController

  def index
    # @orders = Order.all
    @orders = Order.order(params[:sort])
  end

  def new
    @order = Order.create_order_from_cart(params[:cart_id])
  end

  def show
  end

  def edit
  end

  def update
    order.update_attributes(params[:order])
    redirect_to order_path(order)
  end

  def create
    order = Order.new(params[:cart])
    order.save
    redirect_to order_path(order)
  end

  helper_method :order

private

  def order
    @order ||= Order.find(params[:id])
  end
  
end
