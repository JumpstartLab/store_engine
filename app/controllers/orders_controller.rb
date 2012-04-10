class OrdersController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_order, :only => [:show, :edit, :destroy, :update]
  
  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_path, notice: "Cart is empty"
      return 
    end
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    @order.user = current_user

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to products_path, notice: "Thank you for your order" }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
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
    @order = Order.find(params[:id])
  end
end
