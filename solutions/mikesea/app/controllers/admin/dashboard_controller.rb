class Admin::DashboardController < ApplicationController
  before_filter :require_login
  before_filter :is_admin?

  def show
    @orders = Order.orders_by_status(params[:order_status])
    @categories = Category.all
  end

end
