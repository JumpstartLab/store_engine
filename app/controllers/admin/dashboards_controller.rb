class Admin::DashboardsController < ApplicationController
  def show
    @statuses = Order.statuses
    @orders_by_status = Order.collect_by_status

    if params[:status]
      @orders = @orders_by_status[params[:status]]
    else
      @orders = Order.all
    end
  end
end
