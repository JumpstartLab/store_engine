# Base class that inherited by all other classes
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_cart, :verify_user, :stripe_api_key

  def require_admin
    if current_user && !current_user.admin?
      flash[:alert] = "Must be an administrator"
      redirect_to root_url
    elsif current_user.nil?
      not_authenticated
    end
  end

  def require_not_logged_in
    if current_user
      redirect_to root_url, :notice => 'Must not be logged in'
    end
  end

private

  def not_authenticated
    flash[:alert] = "You must login first"
    redirect_to '/login'
  end

  def stripe_api_key
    Stripe.api_key = ENV['STRIPE_TOKEN'] if Rails.env.to_s == "production"
  end
  
  def find_cart
    current_user ? find_cart_for_user : find_cart_for_guest
  end

  def find_cart_for_user
    current_user.cart = Cart.create if current_user.cart.nil?
    merge_carts(cookies[:cart_id]) if !cookies[:cart_id].blank?
    @cart = current_user.cart
  end

  def find_cart_for_guest
    if cookies[:cart_id].blank?
      @cart = Cart.create
      cookies[:cart_id] = @cart.id
    else
      @cart = Cart.find(cookies[:cart_id])
    end
  end

  def merge_carts(old_cart_id)
    current_user.cart.merge(old_cart_id)
    destroy_cart
  end

  def destroy_cart
    Cart.find(cookies[:cart_id]).destroy
    cookies[:cart_id] = nil
  end

  def verify_user
    @cart.add_user(current_user)
  end

end
