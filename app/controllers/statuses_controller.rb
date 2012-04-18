class StatusesController < ApplicationController
  before_filter :admin_authorize

  def show
  end

  def index
    @orders = Status.find_by_status(params[:name])
  end

end