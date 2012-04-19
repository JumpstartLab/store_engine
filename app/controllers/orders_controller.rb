class OrdersController < ApplicationController

  before_filter :require_login
  before_filter :belongs_to_current_user?, only: [:show]

  def new
    redirect_to new_credit_card_path and return if current_user.credit_cards.empty?
    redirect_to new_shipping_detail_path and return if current_user.shipping_details.empty?

    @credit_card = current_user.credit_cards.last
    @shipping_detail = current_user.shipping_details.last
    @order = Order.new
  end

  def index
    @orders = current_user.orders.desc
  end

  def create
    @order = current_user.orders.create
    @order.build_order_from_cart(current_cart)
    token = params[:order][:customer_token] #from stripe
    @order.shipping_detail = current_user.shipping_details.find(params[:order][:shipping_detail_id])
    @order.save

    if @order.set_cc_from_stripe_customer_token(token)
      if @order.charge(current_cart)
        current_cart.destroy
        redirect_to @order, :notice => "Thank you for placing an order."
      end
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    @shipping_detail = @order.shipping_detail
    redirect_to root_path, :notice => "Order not found." if @order.nil?
  end

private
  def belongs_to_current_user?
    redirect_to_last_page unless Order.user_by_order_id(params[:id]) == current_user
  end

end
