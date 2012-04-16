require 'date'

class OrdersController < ApplicationController
  def index
    unless logged_in?
      not_found
    end
    @orders = Order.where("user_id = ?", current_user)
  end

  def create
    status = Status.find_by_name("pending")
    shipping_address = ShippingAddress.find(session[:shipping_address])
    billing_address = BillingAddress.find(session[:billing_address])
    @order = Order.new(:status => status, :user => current_user,
                       :shipping_address => shipping_address,
                       :billing_address => billing_address, 
                       :status_updated_at => DateTime.now)
    cart.cart_items.each do |item|
      @order.order_items << OrderItem.new(:product => item.product, 
                                          :price => item.price, 
                                          :quantity => item.quantity)
    end

    if @order.save
      flash[:notice] = "Thank you for your order"
      cart.clear
      redirect_to order_path(@order)
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end 
