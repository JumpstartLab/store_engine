class Admin::OrderItemsController < ApplicationController
  def edit
    @order_item = OrderItem.find(params[:id])
  end

  def update
    OrderItem.find(params[:id]).update_attributes(params[:order_items])
    redirect_to admin_order_path(@order)
  end

  def destroy
    item = OrderItem.find(params[:id])
    item.destroy
    redirect_to admin_order_path(@order)
  end
end