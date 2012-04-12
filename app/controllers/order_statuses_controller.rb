class OrderStatusesController < ApplicationController

  def create
    order = Order.find(params[:order_id])
    # order.ship
    # order.upgrade
    order.order_statuses.new(:status => params[:status])
    order.save
    redirect_to admin_dashboard_path
  end

end