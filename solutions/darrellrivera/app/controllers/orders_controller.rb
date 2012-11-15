class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    notice = "You are not authorized to view that order. #scriptkiddiefail"
    redirect_to root_path, :notice => notice unless @order.user == current_user
  end

  def index
    @orders = []
    @orders = Order.find_all_by_user_id(current_user.id) if current_user
  end
end
