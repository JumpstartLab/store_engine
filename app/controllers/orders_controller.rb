class OrdersController < ApplicationController
  before_filter :check_logged_in

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
    @order ||= current_user.orders.find_by_id(params[:id])
  end

  def update
    @order ||= current_user.orders.find_by_id(params[:id])
    redirect_to order_path(@order)
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    unless @order
      redirect_to root_url, :notice => "DON'T TOUCH THAT"
    end
  end

end
