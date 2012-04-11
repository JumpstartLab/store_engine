class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
  end

  helper_method :order

private

  def order
    @order ||= Order.find(params[:id])
  end
  
end
