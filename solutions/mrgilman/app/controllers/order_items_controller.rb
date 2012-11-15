class OrderItemsController < ApplicationController
  before_filter :admin_or_not_found, :only => :destroy

  def destroy
    OrderItem.find(params[:id]).delete
    redirect_to request.referer
  end
end
