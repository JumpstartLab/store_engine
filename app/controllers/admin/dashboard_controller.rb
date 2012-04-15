class Admin::DashboardController < ApplicationController
  def index
    @status_options = [['Pending', 'Pending'], ['Cancelled', 'Cancelled']]
    @dashboard = Dashboard.new 
  end
end
