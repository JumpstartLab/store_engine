class OrdersController < ApplicationController
  before_filter :skip_mini_cart
  before_filter :require_login, only: [:index, :show]
  before_filter :find_order, only: [:show, :destroy]

  def show

  end

  def index
    @orders = current_user.orders
  end

  def new

  end

  def create
    @order = Order.build_with_user(params[:order], current_user)
    if @order.save
      @order.add_items_from_cart!(current_cart)
      current_user.update_addresses(params) if current_user
      @order.update_attribute(:status, "paid")
    else
      flash[:error] = @order.errors.full_messages.join(", ").html_safe
      redirect_to :back
    end
  end

  def destroy
    if @order
      @order.update_attribute(:status, "cancelled")
    end
    redirect_to orders_path
  end

  def find_order
    if params[:id]
      @order = current_user.orders.find(params[:id])
    end
  end

end
