class OrderController < ApplicationController

  before_filter :lookup_order, :only => [:show, :edit, :destroy, :update]
  
  def index
    @orders = order.all
  end

  def show
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  def new
    @order = order.new
  end

  def create
    @order = order.new(params[:order])
    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @order.update_attributes(params[:order])
    @order.save
    redirect_to order_path(@order)
  end

  def lookup_order
    @order = order.find(params[:id])
  end
end
