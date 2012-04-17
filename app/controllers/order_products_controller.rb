class OrderProductsController < ApplicationController
  def update
    order_product = OrderProduct.find_by_id(params[:id])
    if order_product.update_attributes(:quantity => params[:order_product][:quantity])
      redirect_to admin_order_path
    else
      redirect_to order_path(order_product.order), :notice => "Can't Change Quantity for this order."
    end
  end

end
