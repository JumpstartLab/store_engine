class InstantOrdersController < ApplicationController
  before_filter :check_logged_in
  def create
    params[:quantity] ||= 1

    if user_defaults?(current_user)
      create_order_from_params(current_user)
      if @order.save
        redirect_to_new_order
      else
        redirect_to (:back), :notice => "Something went wrong."
      end
    else
      redirect_to user_path(current_user)
    end
  end

private
  def user_defaults?(user)
    if user.default_billing_address  &&
       user.default_shipping_address &&
       user.default_credit_card
      true
    else
      false
    end
  end

  def create_order_from_params(user)
    @order = Order.new
    @order.user = current_user
    fill_in_order_from_user_defaults(current_user)
    @order.add_product_by_product_id(params[:product_id], params[:quantity])
    @order.order_statuses.new(:status => "paid")
  end

  def fill_in_order_from_user_defaults(user)
    @order.billing_address = user.default_billing_address
    @order.shipping_address = user.default_shipping_address
    @order.credit_cards << user.default_credit_card
  end

  def redirect_to_new_order
    params[:order] = @order.to_param
    redirect_to order_path(@order)
  end
end
