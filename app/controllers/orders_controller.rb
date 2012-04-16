class OrdersController < ApplicationController

  before_filter :authorize
  
  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order_cart = @cart
    @order.build_address
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    redirect_to order_path(@order)
  end

  def create
    @order = Order.new(params[:order])
    @order.status = "pending"
    @order.user_id = current_user.id
    @order.save
    @order.add_order_items_from(@cart) 
    @order.address.user = current_user
    @cart.destroy
    session[:cart_id] = nil
    

    if @order.save_with_payment
      redirect_to @order, :notice => "You bought something with Stripe. Want a medal or something?"
    else
      render :new
    end
  end
end
