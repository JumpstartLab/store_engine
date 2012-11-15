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
  end

  def one_click
    product = Product.find(params[:product_id])
    @order = Order.one_click_order(product, current_user)

    if @order.errors.empty?
      redirect_to order_path(@order),notice: "Thank you for your order"
    else
      @cart = current_cart
      render action: 'new'
    end
  end

  def create
    check_for_empty_cart
    if @order.save
      build_order
      redirect_to order_path(@order), notice: "Thank you for your order"
    else
      reset_upon_failed_order
    end
  end

  def check_for_empty_cart
    @order.user = current_user
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_path, notice: "Cart is empty"
      return
    end
  end

  def build_order
    @order.add_contents_of_cart(@cart, @order)
    @order.status = "paid"
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def reset_upon_failed_order
    @cart = current_cart
    render action: 'new'
  end

  def edit
  end

  def update
    @order.update_attributes(params[:order])
    @order.save
    update_status
    redirect_to order_path(@order)
  end

  def update_status
    case params[:order][:status]
      when "shipped" then @order.ship
      when "cancelled" then @order.cancel
      when "paid" then @order.pay
    end
  end

  def lookup_order
    @order = Order.find(params[:id])
  end
end
