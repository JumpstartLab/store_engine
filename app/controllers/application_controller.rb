class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :lookup_cart

  private

  def lookup_cart
    if current_user # if someone is logged in
      current_user.cart = Cart.create if current_user.cart.nil?
      @cart = current_user.cart
      if @cart.id != session[:cart_id]
        merge_cart(session[:cart_id]) if !session[:cart_id].blank?
      end
    else 
      if session[:cart_id]
        @cart = Cart.find_by_id(session[:cart_id])
      else
        @cart ||= Cart.create
        session[:cart_id] = @cart.id
      end
    end
  end

  def merge_cart(session_cart_id)
    session_cart = Cart.find_by_id(session_cart_id)
    if !session_cart.nil?
      session_cart.cart_items.each do |ci|
        if !@cart.items.include?(ci.product)
          @cart.cart_items << ci
        else
          @cart.increment_quantity_for(ci.product_id, ci.quantity)
        end
      end
    end
    session[:cart_id] = @cart.id
  end

  def authorize
    if current_user.nil?
      session[:request_page] = request.path
      redirect_to new_session_path, alert: "You need to log in first."
    end
  end

  def admin_authorize
    redirect_to root_url, alert: "Not an admin and totally not cool." unless admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin?
    if current_user
      current_user.admin
    else
      false
    end
  end

  helper_method :lookup_cart
  helper_method :admin_authorize
  helper_method :current_user
  helper_method :admin?
end
