class OrdersController < ApplicationController
  before_filter :lookup_order, :only => [:show, :edit, :destroy, :update]
  # before_filter :require_admin


  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    order = Order.create(params[:order])
    redirect_to order_path(order)
  end

  def destroy
    Order.destroy(@order)
    redirect_to orders_path
  end

  def edit
  end

  def update
    @order.update_attributes(params[:order])
    redirect_to order_path(@order)
  end

  private

  def lookup_order
    @order = Order.find(params[:id])
  end
end
