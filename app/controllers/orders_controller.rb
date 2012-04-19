class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = []
    @orders = Order.find_all_by_user_id(current_user.id) if current_user
  end
end
