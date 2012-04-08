class OrdersController < ApplicationController
  before_filter :skip_mini_cart
  before_filter :find_orders, except: [:create, :new]

  def index
    
  end

  def new

  end

  def create
    if current_user
      @order = current_user.orders.create!
      current_cart.cart_items.each do |cart_item|
        @order.order_items.create(product_id: cart_item.product_id,
                                  quantity: cart_item.quantity)
      end
      current_cart.destroy
    else
      flash[:error] = "You must sign in to place an order."
      redirect_to login_path
    end
  end

  def destroy
    if @order
      @order.update_attribute(:status, "Cancelled")
    end
    redirect_to orders_path
  end

  def find_orders
    @orders = current_user.orders
    if params[:id]
      @order = current_user.orders.find(params[:id])
    end
  end
  
end
