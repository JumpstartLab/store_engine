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

  # def update
  #   @order_item.update_attributes(params[:order_item])
  #   @order_item.save
  #   redirect_to order_path(@order_item.order)
  # end

  def update
    @order_item = OrderItem.find(params[:id])
    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to order_path(@order_item.order), notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to order_path(@order_item.order), notice: 'Quantity must be greater than 0' }
        format.json { render json: @order_item.order, status: :unprocessable_entity }
      end
    end
  end

  def lookup_order_item
    @order_item = OrderItem.find(params[:id])
  end
end
