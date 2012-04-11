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
      notice = 'Please input a valid shipping method'
      redirect_to order_path(order), notice: notice
    end
  end

  def destroy
  end

  def show
  end

  def create
    shipping = ShippingAddress.new(params[:shipping_address])
    order = Order.find(session[:order_id])
    if shipping.save
      notice = "Shipping Address Successfully Added"
      order.update_attribute(:shipping_address_id, shipping.id)
      redirect_to order_path(order), notice: notice
    else
      notice = 'Please input a valid shipping method'
      redirect_to order_path(order), notice: notice
    end
  end

  def new
    @shipping_address = ShippingAddress.new
  end
end
