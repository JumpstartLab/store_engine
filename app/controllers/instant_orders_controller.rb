class InstantOrdersController < ApplicationController
  before_filter :check_logged_in
  def create
    params[:quantity] ||= 1
    user = current_user

    order = Order.new
    order.billing_address = user.default_billing_address
    order.shipping_address = user.default_shipping_address
    order.credit_cards << user.default_credit_card
    order.add_product_by_product_id(params[:product_id], params[:quantity])

    if order.save
      params[:order] = order.to_param
      redirect_to order_path(order)
    else
      render :action => 'create', :notice => "Something went wrong."
    end
  end
end
