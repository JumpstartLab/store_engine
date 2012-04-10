class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
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
