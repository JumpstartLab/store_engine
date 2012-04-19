class OrdersController < ApplicationController

  before_filter :authorize
  before_filter :admin_authorize, only: [:edit, :update]

  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
    @address = @order.address
  end

  def new
    if @cart.quantity == 0
      redirect_to '/',
      :alert => "You can't order something with nothing in your cart."
    else
      @order = Order.new
      @order_cart = @cart
      @order.build_address
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.status.update_attribute(:name, params[:order][:status])
    redirect_to order_path(@order)
  end

  def create
    @order = Order.new(params[:order])
    @order.status = Status.new
    @order.user_id = current_user.id
    @order.save
    create_part_two
  end

  def create_part_two
    @order.add_order_items_from(@cart)
    @order.address.user = current_user
    @cart.destroy
    session[:cart_id] = nil
    create_part_three
  end

  def create_part_three
    if @order.save_with_payment
      UserMailer.order_confirmation(current_user, @order).deliver
      create_part_four
    else
      render :new
    end
  end

  def create_part_four
    @order.status.change
    redirect_to @order,
    :notice => "Transaction Complete"
  end
end
