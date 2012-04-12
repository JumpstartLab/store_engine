class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    #@orders = Order.all
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find_by_id(params[:id])
  end

  def mark_shipped
    order = Order.find_by_id(params[:id])
    order.status = "shipped"
    order.save
    redirect_to admin_dashboard_path
  end

  def mark_cancelled
    order = Order.find_by_id(params[:id])
    order.status = "cancelled"
    order.save
    redirect_to admin_dashboard_path
  end

  def mark_returned
    order = Order.find_by_id(params[:id])
    order.status = "returned"
    order.save
    redirect_to admin_dashboard_path
  end

end
