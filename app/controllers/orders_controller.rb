class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:index]

  def index
    status = Status.find_by_name(params[:status]) if params[:status]

    if not status
      @orders = Order.all
    else
      @orders = Order.where(:status_id => status.id)
    end

    @orders_by_status = {}
    Order.count(:group => "status_id").each do |id,c|
      @orders_by_status[Status.find(id)] = c
    end

    @statuses = Status.all
  end

  def show
    @order = Order.find(params[:id])
  end

end
