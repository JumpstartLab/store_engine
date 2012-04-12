class BillingMethodsController < ApplicationController
  def new
    @billing_method = BillingMethod.new
  end
  def edit
    @billing_method = BillingMethod.find_by_order_id(session[:order_id])
  end

  def create
    billing = BillingMethod.new(params[:billing_method])
    if billing.save
      notice = "Billing Address Successfully Added"
      if logged_in?
        billing.update_attribute(:user_id, current_user.id)
        if current_user.has_pending_order?
          order = Order.find(session[:order_id])
          order.update_attribute(:billing_method_id, billing.id)
          redirect_to order_path(order), notice: notice
        else
          redirect_to user_path(current_user)
        end
      else
        order = Order.find(session[:order_id])
        order.update_attribute(:billing_method_id, billing.id)
        redirect_to order_path(order), notice: notice
      end
    else
      notice = 'Please input a valid billing method'
      render :new, notice: notice
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
