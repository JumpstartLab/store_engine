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
end
