class DashboardController < ApplicationController
  
  before_filter :admin_authorize

  def show
  end
end
