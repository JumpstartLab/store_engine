class TwoClickOrdersController < ApplicationController
  before_filter :authorize

  def create
    if current_user.addresses.first && current_user.stripe_id
      @order = Order.new
      @order.user = current_user
      @order.status = Status.new
      @order.save
      @order.address = current_user.addresses.first
      cart = Cart.create
      cart.add_or_increment_by_product(params[:product_id])
      @order.add_order_items_from(cart)
      if @order.save_with_payment
        @order.status.change
        redirect_to order_path(@order.id),
        :notice => "Transaction Successful" and return
      end
    end
    @cart.add_or_increment_by_product(params[:product_id])
    redirect_to '/cart',
    :alert => "You don't have a saved credit card.
              Please make a regular purchase,
              and Instant Purchase will be available next time."
  end

  def new_order_creation
    if current_user.addresses.first && current_user.stripe_id
      @order = Order.new
      @order.user = current_user
      @order.status = Status.new
      @order.save
      @order.address = current_user.addresses.first
      cart = Cart.create
      cart.add_or_increment_by_product(params[:product_id])
      @order.add_order_items_from(cart)
      if @order.save_with_payment
        @order.status.change
        redirect_to order_path(@order.id),
        :notice => "Transaction Successful" and return
      end
    end
  end

  def show
    redirect_to '/',
    :alert => "You need to be logged in to instant purchase."
  end
end
