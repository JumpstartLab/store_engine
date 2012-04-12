require 'date'

class OrdersController < ApplicationController
  def create
    @order = Order.new(:status => Status.find_by_name("pending"), :user => current_user,
                       :shipping_address => ShippingAddress.find(session[:shipping_address]), 
                       :billing_address => BillingAddress.find(session[:billing_address]), :status_updated_at => DateTime.now)
    cart.cart_items.each do |item|
      @order.order_items << OrderItem.build(:product => item.product, :price => item.price, :quantity => item.quantity)
    end
    @order.save
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find(params[:id])
  end
end