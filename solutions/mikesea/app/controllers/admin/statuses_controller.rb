class Admin::StatusesController < ApplicationController
  before_filter :require_login
  before_filter :is_admin?

  def create
    # raise params.inspect
  end

  def update
    @order_status = OrderStatus.find_by_order_id(params[:order_id])
    @order_status.update_status(params[:new_status])
    redirect_to_last_page("Status updated!")
  end

end