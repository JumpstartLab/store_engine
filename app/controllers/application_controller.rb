class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    if session[:cart_id]
      cart = Cart.find_by_id(session[:cart_id])
    end
    cart ||= Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def authorize
    redirect_to root_url, alert: "Not authorized" if current_user.nil?
  end

  def admin_authorize
    redirect_to root_url, alert: "Not an admin authorized" unless admin?
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

  helper_method :admin_authorize
  helper_method :current_user
  helper_method :admin?
end
