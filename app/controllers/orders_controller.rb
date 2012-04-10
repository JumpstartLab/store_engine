class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:index]
  before_filter :require_logged_in, :only => [:new]

  def index
    status = Status.find_by_name(params[:status]) if params[:status]

    if not status
      @orders = Order.all
    else
      @orders = Order.where(:status_id => status.id)
    end

    @statuses = Status.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order.process_cart(@cart)
    raise @order.products.inspect
  end
end
