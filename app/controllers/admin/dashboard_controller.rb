class Admin::DashboardController < ApplicationController
  before_filter :admin_or_not_found

  def index
    @dashboard = Dashboard.new 

    @status = params[:status]
    if @status.nil?
      @status = StoreEngine::Status::PENDING
    end
    @orders = @dashboard.orders_with_status(@status)
  end

  helper_method :order_action?
  def order_action?
    if @status == StoreEngine::Status::PENDING ||
       @status == StoreEngine::Status::PAID ||
       @status == StoreEngine::Status::SHIPPED
      true
    else
      false
    end
  end
end
