class CartItemsController < ApplicationController
  def create
    @cart.add_or_increment_by_product(params[:product_id])
    
    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Added to cart.' }
      format.js
    end
  end

  def edit
    @cart_item = CartItem.find(params[:id])
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update_attributes(params[:cart_item])
    delete_on_zero
    redirect_to cart_path
  end

  def delete_on_zero
    if @cart_item.quantity == 0 
      @cart_item.destroy
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end
end
