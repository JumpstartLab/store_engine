class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(:user_id => current_user, :status => 'pending')
    @order.stripe_card_token = params[:order][:stripe_card_token]
    if @order.save_customer
      if @order.charge(current_cart.cart_total_in_cents)
        redirect_to @order, :notice => "Thank you for placing an order."
      end
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
