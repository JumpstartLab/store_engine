class BillingMethodsController < ApplicationController
  def new
    session[:return_to] ||= request.referrer
    @billing_method = BillingMethod.new
  end
  def edit
    session[:return_to] ||= request.referrer
    if logged_in?
      @billing_method = current_user.billing_method
    else
      @billing_method = BillingMethod.find_by_order_id(session[:order_id])
    end
  end

  def create
    billing = BillingMethod.new(params[:billing_method])
    if billing.save
      notice = "Billing Address Successfully Added"
      billing.update_attribute(:user_id, current_user.id) if logged_in?
      if session[:order_id]
        order = Order.find(session[:order_id])
        order.update_attribute(:billing_method_id, billing.id)
      end
    else
      notice = 'Please input a valid billing method'
    end
    redirect_to session[:return_to], notice: notice
  end

  def update
    if logged_in?
      billing = current_user.billing_method
    else
      order = Order.find(session[:order_id])
      billing = BillingMethod.find(order.billing_method_id)
    end
    if billing.update_attributes(params[:billing_method])
      notice = "Billing Address Successfully Saved"
    else
      notice = 'Please input a valid billing method'
    end
    redirect_to session[:return_to], notice: notice
  end
end
