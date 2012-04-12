class Admin::DashboardController < ApplicationController

  def show
    @orders = Order.orders_by_filter(params[:order_status])
  end


end
