class OrdersController < ApplicationController

  before_filter :authorize, only: [:new]
  
  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order_cart = @cart
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    redirect_to order_path(@order)
  end

  def create
    @order = Order.new(status: "pending")
    @order.user_id = current_user.id
    @order.save
    @order.add_order_items_from(@cart) 
    redirect_to orders_path# what about duplicate sesso
  end
end
