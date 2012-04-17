class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    #@orders = Order.all
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find_by_id(params[:id])
  end

end
