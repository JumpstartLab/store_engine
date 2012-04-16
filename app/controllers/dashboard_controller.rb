class DashboardController < ApplicationController
  
  before_filter :admin_authorize

  def show
    @orders = Order.all
  end
end
