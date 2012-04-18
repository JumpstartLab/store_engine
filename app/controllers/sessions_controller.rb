#
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_address(params[:email])
    if valid_user?(user)
      set_user_session(user)
      if user_has_two_carts?(user)
        merge_cart(user)
      elsif session[:order_id]
        add_user_to_order
      end
      redirect_to root_url, :notice => "Welcome Back, #{user.full_name}"
    else
      render :new, :notice => 'Try again'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_url, :notice => 'Thanks for Visting'
  end

  private

  def valid_user?(user)
    user && user.authenticate(params[:password])
  end

  def user_has_two_carts?(user)
    user.has_pending_order? && session[:order_id]
  end

  def set_user_session(user)
    session[:user_id] = user.id
  end

  def merge_cart(user)
    order = Order.find(session[:order_id])
    order.line_items.each do |li|
      LineItem.increment_or_create_line_item(price: li.price,
        product_id: li.product_id, quantity: li.quantity,
        order_id: user.pending_order.id)
    end
    session[:order_id] = user.pending_order.id
  end

  def add_user_to_order
    order = Order.find(session[:order_id])
    order.add_user(session[:user_id])
    order.try_to_add_billing_and_shipping(session[:user_id])
  end
end