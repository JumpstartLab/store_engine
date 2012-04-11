class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_cart, :verify_user

  def require_admin
    if current_user && !current_user.admin
      redirect_to root_url, :notice => "Must be an administrator"
    elsif current_user.nil?
      redirect_to '/login', :notice => "Must be an administrator"
    end
  end

  def require_logged_in
    redirect_to '/login', :notice => "You must login first" if !current_user
  end

  def require_not_logged_in
    redirect_to root_url, :notice => 'Must not be logged in' unless !current_user
  end

private

  def find_cart
    if current_user
      current_user.cart = Cart.create if current_user.cart.nil?
      @cart = current_user.cart
      merge_carts if !cookies[:cart_id].blank?
    else
      if cookies[:cart_id].blank?
        @cart = Cart.create
        cookies[:cart_id] = @cart.id
      else
        @cart = Cart.find(cookies[:cart_id])
      end
    end
  end

  def merge_carts
    Cart.find(cookies[:cart_id]).products.each do |p|
      @cart.add_product(p.id)
    end
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
