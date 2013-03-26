class Admin::DashboardController < ApplicationController
  def index
    @orders = Order.all
  end
end
