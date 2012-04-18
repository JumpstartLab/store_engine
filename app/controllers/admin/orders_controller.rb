class Admin::OrdersController < ApplicationController
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
    Order.find(params[:id]).update_attributes(params[:order])
    redirect_to :back
  end

  def destroy
    OrderItem.find(params[:item_id]).destroy
    redirect_to admin_order_path(Order.find(params[:id])), :notice => "Item Deleted Bitch"
  end
end
