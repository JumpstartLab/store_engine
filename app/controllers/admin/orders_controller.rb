class Admin::OrdersController < ApplicationController
  before_filter :require_admin

  def index
    @orders = Order.all
  end

  def show
  end

  def update
  end
end
