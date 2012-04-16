class Admin::DashboardController < ApplicationController
  def index
    @dashboard = Dashboard.new 

    @status = params[:status]
    if @status.nil?
      @status = StoreEngine::Status::PENDING
    end
    @orders = @dashboard.orders_with_status(@status)
  end
end
