#
class ShippingAddressesController < ApplicationController
  before_filter :load_shipping_address, only: [:edit, :update]
  before_filter :validate_shipping_user, only: [:edit]

  def index
    redirect_to root_url
  end

  def new
    session[:return_to] = request.referrer
    @shipping_address = ShippingAddress.new
  end
  def edit
    session[:return_to] = request.referrer
  end

  def show
    redirect_to root_url
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    try_to_save_shipping
  end

  def update
    if @shipping_address.update_attributes(params[:shipping_address])
      notice = "Shipping Address Successfully Saved"
      redirect_to session[:return_to], notice: notice
    else
      notice = 'Please input a valid shipping address'
      render :edit
    end
  end

  private

  def try_to_save_shipping
    if @shipping_address.save
      save_shipping
    else
      render :new
    end
  end

  def save_shipping
    notice = "Shipping Address Successfully Added"
    if logged_in?
      @shipping_address.update_attribute(:user_id, current_user.id)
    end
    if session[:order_id]
      order = Order.find(session[:order_id])
      order.update_attribute(:shipping_address_id, @shipping_address.id)
    end
    redirect_to session[:return_to]
  end

  def load_shipping_address
    if logged_in?
      @shipping_address = current_user.shipping_address
    else
      @shipping_address = ShippingAddress.find_by_order_id(session[:order_id])
    end
  end
end