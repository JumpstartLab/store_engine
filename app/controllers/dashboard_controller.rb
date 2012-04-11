class DashboardController < ApplicationController

  def show
    @orders = Order.all
  end

end