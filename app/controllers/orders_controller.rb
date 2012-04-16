class OrdersController < ApplicationController

  before_filter :require_login
  before_filter :belongs_to_current_user?, only: [:show]

  def new
    @order = Order.new
  end

  def index
    @orders = current_user.orders.desc
  end

  def create
    @order = Order.new(:user_id => current_user.id)
    @order.stripe_card_token = params[:order][:stripe_card_token]

    if @order.save_credit_card && @order.charge(current_cart)
        current_cart.assign_cart_to_order_and_destroy(@order)
        OrderStatus.create(:status => 'paid', :order_id => @order.id)
        redirect_to @order, :notice => "Thank you for placing an order."
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    redirect_to root_path, :notice => "Order not found." if @order.nil?
  end

private
  def belongs_to_current_user?
    redirect_to_last_page unless Order.user_by_order_id(params[:id]) == current_user
  end

end
