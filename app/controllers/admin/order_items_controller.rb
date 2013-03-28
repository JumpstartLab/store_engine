class Admin::OrderItemsController < ApplicationController
  before_filter :require_admin

  def update
    @order_item = OrderItem.find(params[:admin_order_item][:order_item_id])
    @order_item.quantity = params[:admin_order_item][:quantity]
    if @order_item.save
      redirect_to :back, :notice => "Successfully updated order item."
    else
      redirect_to :back, :notice => "FAIL! :("
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item.destroy
      redirect_to :back, :notice => "Successfully deleted order item."
    else
      redirect_to :back, :notice => "FAIL! :("
    end
  end
end
