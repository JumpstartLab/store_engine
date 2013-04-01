class Admin::OrdersController < ApplicationController
  before_filter :require_admin

  def index
    @count = Order.count
    @orders = Search.filter_admin_orders(params)
    @statuses = Order.count(group: :status)
    @active_tab = params[:status] || 'all'
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if params[:update_status]
      @order.update_status
    end
    redirect_to(:back)
  end
end
