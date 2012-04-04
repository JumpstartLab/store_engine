class OrdersController < ApplicationController

  def index
    redirect_to root_path
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

  
end
