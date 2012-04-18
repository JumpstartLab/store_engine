require 'date'

class OrdersController < ApplicationController
  before_filter :find_order, :only => [:show, :update]
  before_filter :admin_or_not_found, :only => :update

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

    @order.charge(session[:transaction], cart.total.cents)

    if @order.save
      flash[:notice] = "Thank you for your order"
      cart.clear
      redirect_to order_path(@order)
    end
  end

  def show
    @shipping_address = @order.shipping_address
    @billing_address = @order.billing_address
  end

  def update
    previous_status_name = @order.status.name
    @order.update_status
    redirect_to admin_dashboard_index_path(:status => previous_status_name)
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end 
