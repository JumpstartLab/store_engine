class OrdersController < ApplicationController

  def create
    @order = Order.create
    if @order.save
      params[:order] = @order.to_param
      redirect_to edit_order_path(@order)
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
  end

end
