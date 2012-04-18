class OrdersController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_order, :only => [:show, :edit, :destroy, :update]

  def index
    @orders = current_user.orders
  end

  def admin_report
    if params[:filter]
      @orders = Order.where(:status => params[:filter])
    else
      @orders = Order.all
    end
    if can? :manage, @orders
      return render action: :index
    end
    @orders
  end


  def show
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_path, notice: "Cart is empty"
      return 
    end
    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def one_click
    product = Product.find(params[:product_id])
    @order = Order.one_click_order(product, current_user)

    respond_to do |format|
      if @order.errors.empty?
        format.html { redirect_to product_path(product), notice: "Thank you for your order" }
        format.json { render json: @order, status: :created, location: @order }
      else
        @cart = current_cart
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end  

  def create
    @cart = current_cart
    @order.user = current_user

    if @cart.line_items.empty?
      redirect_to products_path, notice: "Cart is empty"
      return 
    end
      
    respond_to do |format|
      if @order.save
        @order.add_contents_of_cart(@cart, @order)
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
    case params[:order][:status]
      when "shipped" then @order.ship
      when "cancelled" then @order.cancel
      when "paid" then @order.pay
    end
    redirect_to order_path(@order)
  end

  def lookup_order
    @order = Order.find(params[:id])
  end
end
