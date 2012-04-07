class CartsController < ApplicationController
  before_filter :find_cart, :verify_user

  def update
    @cart.add_product(params[:product_id])
    redirect_to cart_path, :notice => "Product added to cart"
  end

  def show
  end

  def destroy
    @cart.remove_product(params[:product_id])
    redirect_to cart_path, :notice => "Product deleted."
  end

  private

  def find_cart
    if current_user
      @cart = current_user.cart
      merge_carts
    else
      session[:cart_id] = Cart.create.id if session[:cart_id].nil?
      @cart = Cart.find(session[:cart_id]) 
    end
  end

  def verify_user
    @cart.add_user(current_user)
  end

  def merge_carts
    if session[:cart_id]
      raise "making it here"
      Cart.find(session[:cart_id]).products.each do |p|
        @cart << p
      end
    end
  end
end
