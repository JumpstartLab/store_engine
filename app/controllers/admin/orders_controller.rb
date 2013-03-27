class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
  end

  def update
  end
end
