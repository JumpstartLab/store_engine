class TwoClickOrdersController < ApplicationController

  before_filter :authorize

  def create
    if current_user.addresses.first && current_user.stripe_id
      order = Order.new
      order.user = current_user
      # order.status = "pending"
      order.save
      order.address = current_user.addresses.first
      
      cart = Cart.create
      cart.add_or_increment_by_product(params[:product_id])
      order.add_order_items_from(cart)
      
      if order.save_with_payment
        redirect_to order, :notice => "You bought something with Stripe. Want a medal or something?"
      else
        redirect_to root_url
      end
    end
  end
end
