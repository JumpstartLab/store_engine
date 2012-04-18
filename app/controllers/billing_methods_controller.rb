class BillingMethodsController < ApplicationController
  before_filter :load_billing_method, only: [:edit, :update]
  before_filter :validate_billing_user, only: [:edit]


  def new
    session[:return_to] = request.referrer
    @billing_method = BillingMethod.new
  end
  def edit
    session[:return_to] = request.referrer
  end

  def create
    @billing_method = BillingMethod.new(params[:billing_method])
    if validate_billing_user
      if @billing_method.save
        notice = "Billing Address Successfully Added"
        @billing_method.update_attribute(:user_id, current_user.id) if logged_in?
        if session[:order_id]
          order = Order.find(session[:order_id])
          order.update_attribute(:billing_method_id, @billing_method.id)
        end
      else
        notice = 'Please input a valid billing method'
      end
      redirect_to session[:return_to], notice: notice
    end
  end

  def update
    if @billing_method.update_attributes(params[:billing_method])
      notice = "Billing Address Successfully Saved"
    else
      notice = 'Please input a valid billing method'
    end
    redirect_to session[:return_to], notice: notice
  end
end

private

def load_billing_method
  if logged_in?
    @billing_method = current_user.billing_method
  else
    @billing_method = BillingMethod.find_by_order_id(session[:order_id])
  end
end