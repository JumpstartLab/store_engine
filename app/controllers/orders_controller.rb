class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    @order.stripe_card_token = params[:order][:stripe_card_token]
    if @order.save_with_payment
      redirect_to @order, :notice => "Thanks a whole bunch."
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
