class BillingMethodsController < ApplicationController
  def new
    @billing_method = BillingMethod.new
  end
  def edit
    @billing_method = BillingMethod.find_by_order_id(session[:order_id])
  end

  def create
    billing = BillingMethod.new(params[:billing_method])
    order = Order.find(session[:order_id])
    if billing.save
      if session[:user_id]
        billing.update_attribute(:user_id, session[:user_id])
      end
      notice = "Billing Address Successfully Added"
      order.update_attribute(:billing_method_id, billing.id)
      redirect_to order_path(order), notice: notice
    else
      notice = 'Please input a valid billing method'
      redirect_to order_path(order), notice: notice
    end
  end

  def update
    order = Order.find(session[:order_id])
    billing = BillingMethod.find(order.billing_method_id)
    if billing.update_attributes(params[:billing_method])
      notice = "Billing Address Successfully Saved"
      redirect_to order_path(order), notice: notice
    else
      notice = 'Please input a valid billing method'
      redirect_to order_path(order), notice: notice
    end
  end
end
