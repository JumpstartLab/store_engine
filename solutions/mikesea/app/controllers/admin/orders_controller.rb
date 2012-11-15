class Admin::OrdersController < ApplicationController
  before_filter :require_login
  before_filter :is_admin?

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
