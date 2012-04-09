class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)
    @cart_item.save
    redirect_to @cart_item.cart
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
end
