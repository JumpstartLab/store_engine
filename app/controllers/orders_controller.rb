class OrdersController < ApplicationController
  before_filter :lookup_order, :only => [:show, :edit, :destroy, :update]
  before_filter :require_order_or_admin, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def destroy
    session[:order_id] = nil if @order.id == session[:order_id]
    Order.destroy(@order)
    redirect_to orders_path
  end

  def edit
  end

  def update
    if @order.billing_method_id && @order.shipping_address_id
      @order.update_attribute(:status, "paid")
      notice = "Thank you for your purchase. You will receive an email confirmation shortly"
      session[:order_id] = nil
      redirect_to root_path, notice: notice
    elsif @order.billing_method_id
      notice = "Please input a valid shipping address"
      redirect_to order_path(@order), notice: notice
    elsif @order.shipping_address_id
      notice = "Please input a valid billing method"
      redirect_to order_path(@order), notice: notice
    else
      notice = "Please input valid billing and shipping information."
      redirect_to order_path(@order), notice: notice
    end
  end

  private

  def lookup_order
    @order = Order.find(params[:id])
  end

end
