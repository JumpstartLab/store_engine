class DashboardController < ApplicationController
  before_filter :require_admin

  def index
    @orders = Order.all
    @orders_by_status = Order.group("status_id").count
    @status = Status.all
  end

end
