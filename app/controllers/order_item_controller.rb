class OrderItemController < ApplicationController


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
    @order_item.update_attributes(params[:order_item])
    @order_item.save
    redirect_to order_item_path(@order_item)
  end

  def lookup_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
end
