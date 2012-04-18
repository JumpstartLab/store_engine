class ShippingAddressesController < ApplicationController
  before_filter :load_shipping_address, only: [:edit, :update]
  before_filter :validate_shipping_user, only: [:edit]

  def new
    session[:return_to] = request.referrer
    @shipping_address = ShippingAddress.new
  end
  def edit
    session[:return_to] = request.referrer
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    if validate_shipping_user
      if @shipping_address.save
        notice = "Shipping Address Successfully Added"
        @shipping_address.update_attribute(:user_id, current_user.id) if logged_in?
        if session[:order_id]
          order = Order.find(session[:order_id])
          order.update_attribute(:shipping_address_id, @shipping_address.id)
        end
      else
        notice = 'Please input a valid shipping address'
      end
      redirect_to session[:return_to], notice: notice
    end
  end

  def update
    if @shipping_address.update_attributes(params[:shipping_address])
      notice = "Shipping Address Successfully Saved"
    else
      notice = 'Please input a valid shipping address'
    end
    redirect_to session[:return_to], notice: notice
  end
end

private

def load_shipping_address
  if logged_in?
    @shipping_address = current_user.shipping_address
  else
    @shipping_address = ShippingAddress.find_by_order_id(session[:order_id])
  end
end