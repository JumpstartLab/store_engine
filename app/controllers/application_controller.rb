class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :find_or_create_cart

  helper_method :current_cart, :current_user, :current_user=

  def current_cart
    @cart ||= find_or_create_cart
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

private

  def require_user
    redirect_to signin_path, alert: 'You must be logged in' if current_user.nil? 
  end

  def find_or_create_cart
    if session[:cart_id]
      Cart.find_by_id(session[:cart_id])
    else
      Cart.create.tap{ |c| session[:cart_id] = c.id }      
    end    
  end

  def user_from_remember_token
    #what will this return now if remember_token.nil? is true?
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end
end
