class OrderItemsController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_order_item, :only => [:show, :edit, :destroy, :update]

  def show
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(params[:order_item])
    if @order_item.save
      redirect_to order_item_path(@order_item)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update_attributes(params[:order_item])
      redirect_to order_path(@order_item.order), notice: 'Order updated.'
    else
      redirect_to order_path(@order_item.order), notice: 'Cannot update.'
    end
  end

  def lookup_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    redirect_to order_path(@order_item.order)
  end
end
