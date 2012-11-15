class Admin::DashboardController < ApplicationController

  def show
    if params[:order_status]
      @orders = Order.send("#{params[:order_status]}")
    else
      @orders = Order.all
    end
  end

end