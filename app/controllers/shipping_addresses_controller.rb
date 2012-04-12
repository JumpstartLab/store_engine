class ShippingAddressesController < ApplicationController
  def index
  end

  def edit
    @shipping_address = ShippingAddress.find_by_order_id(session[:order_id])
  end

  def update
    order = Order.find(session[:order_id])
    shipping = ShippingAddress.find(order.shipping_address_id)
    if shipping.update_attributes(params[:shipping_address])
      notice = "Shipping Address Successfully Saved"
      order.update_attribute(:shipping_address_id, shipping.id)
      redirect_to order_path(order), notice: notice
    else
      notice = 'Please input a valid shipping address'
      redirect_to order_path(order), notice: notice
    end
  end

  def destroy
  end

  def show
  end

  def create
    shipping = ShippingAddress.new(params[:shipping_address])
    if shipping.save
      notice = "Shipping Address Successfully Added"
      if logged_in?
        shipping.update_attribute(:user_id, current_user.id)
        if current_user.has_pending_order?
          order = Order.find(session[:order_id])
          order.update_attribute(:shipping_address_id, shipping.id)
          redirect_to order_path(order), notice: notice
        else
          redirect_to user_path(current_user)
        end
      else
        order = Order.find(session[:order_id])
        order.update_attribute(:shipping_address_id, shipping.id)
        redirect_to order_path(order), notice: notice
      end
    else
      notice = 'Please input a valid shipping address'
      render :new, notice: notice
    end
  end

  def new
    @shipping_address = ShippingAddress.new
  end
end
