class OrdersController < ApplicationController
  before_filter :check_logged_in, :only => :index

  def new
    @order = Order.new
  end

  def index
    @orders = current_user.orders
  end

  def create
    @order = Order.new
    @order.user = current_user
    @order.billing_address = Address.new(params[:order][:billing_address])
    @order.shipping_address = Address.new(params[:order][:shipping_address])
    @order.credit_cards << CreditCard.new(params[:order][:credit_card])
    @order.add_products_by_cart_id(params[:order][:cart_id])

    if @order.save
      params[:order] = @order.to_param
      redirect_to order_path(@order)
    else
      render :action => 'create', :notice => "Something went wrong."
    end
  end

  def edit
    @order ||= Order.find_by_id(params[:id])
  end

  def update
    @order ||= Order.find_by_id(params[:id])
    redirect_to order_path(@order)
  end

  def show
    @order = Order.find_by_id(params[:id])
  end

end
