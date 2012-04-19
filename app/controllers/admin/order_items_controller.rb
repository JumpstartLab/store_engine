class Admin::OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find_by_id(params[:order_item][:id])
    order_item.update_attributes(params[:order_item])
    redirect_to_last_page
  end

  # Commented out b/c we don't seem to use this.
  # Preserved in case we really do need it.
  # def destroy
  #   order_item = OrderItem.find_by_id(params[:id])
  #   order_item.destroy
  #   redirect_to_last_page
  # end
end
