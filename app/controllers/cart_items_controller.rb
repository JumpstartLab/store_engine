class CartItemsController < ApplicationController
  before_filter :find_cart_item

  def create
    if existing_item = current_cart.cart_items.find_by_product_id(params[:product_id])
      existing_item.update_attributes(quantity: existing_item.quantity + 1)
    else
      current_cart.cart_items.create!(product_id: params[:product_id], quantity: 1)
    end
    flash[:notice] = "Item added to cart!"
    redirect_to (request.referer)
  end

  def increase
    if @cart_item
      @cart_item.update_attributes(quantity: @cart_item.quantity + 1)
    end      
    redirect_to request.referer
  end

  def decrease
    if @cart_item
      @cart_item.update_attributes(quantity: @cart_item.quantity - 1)
      @cart_item.destroy if @cart_item.quantity == 0
    end
    redirect_to request.referer
  end

  def remove
    if @cart_item
      @cart_item.destroy
    end
    redirect_to request.referer
  end

  def find_cart_item
    @cart_item = current_cart.cart_items.find_by_id(params[:id])
  end
end
