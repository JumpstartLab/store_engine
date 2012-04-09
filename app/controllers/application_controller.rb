class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :find_or_create_cart_from_session

  def current_cart
    @cart
  end

  def find_or_create_cart_from_session
    if session[:cart_id]
      @cart = Cart.find_by_id(session[:cart_id])
    end
    @cart ||= Cart.create
    session[:cart_id] = @cart.id
    @cart
  end
end
