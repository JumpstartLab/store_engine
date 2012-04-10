class BillingMethodsController < ApplicationController
  def new
    @billing = BillingMethod.new
  end

  def create
    if logged_in?
    else
      billing = BillingMethod.new(params[:billing])
      order = Order.find(session[:order_id])
      if billing.save
        notice = 'Order was successful, check your email for a confirmation.'
        order.update_attributes({billing_method_id: billing.id, status: "paid"})
        session[:order_id] = nil
        redirect_to root_url, notice: notice
      else
        notice = 'Please input a valid billing method'
        redirect_to order_path(order), notice: notice
      end
    end
  end
end
