class OrdersController < ApplicationController
  before_filter :skip_mini_cart
  before_filter :find_order, only: [:show, :destroy]
  before_filter :require_login, only: [:index, :show]

  def show

  end

  def index
    @orders = current_user.orders
  end

  def new

  end

  def create
    @order = Order.create(params.merge(status: 'pending'))
    @order.user_id = current_user.id if current_user
    return redirect_to :back unless @order.save
    current_cart.cart_items.each do |cart_item|
      @order.order_items.create(product_id: cart_item.product_id,
        quantity: cart_item.quantity)
    end
    current_user.update_addresses(params) if current_user
    current_cart.destroy
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
