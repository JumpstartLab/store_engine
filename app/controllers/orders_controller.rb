class OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    redirect_to order_path(@order)
  end
end
