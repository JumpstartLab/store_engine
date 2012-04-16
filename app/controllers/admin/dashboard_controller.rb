class Admin::DashboardController < ApplicationController

  def show
    @orders = Order.orders_by_status(params[:order_status])
  end

end
