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

  def checkout

  end

private

  def find_cart
    if current_user
      @cart = current_user.cart
      merge_carts
    else
      cookies[:cart_id] = Cart.create.id if cookies[:cart_id].nil?
      @cart = Cart.find(cookies[:cart_id])
    end
  end

  def verify_user
    @cart.add_user(current_user)
  end

  def merge_carts
    if cookies[:cart_id]
      Cart.find(cookies[:cart_id]).products.each do |p|
        @cart.products << p
      end
    end
  end
  
end
