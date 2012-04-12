class CartsController < ApplicationController
  
  def update
    @cart.add_product(params[:product_id])
    if @cart.save
      redirect_to cart_path, :notice => "Product added to cart"
    end
  end

  def show
  end

  def destroy
    @cart.remove_product(params[:product_id])
    redirect_to cart_path, :notice => "Product deleted."
  end

  def checkout

  end
  def update_quantity
    @cart.update_quantity(params[:cart][:cart_products_attributes])
    if cart.save
      redirect_to cart_path, :notice => "Cart updated successfully"
    else
      flash[:error] = "Your cart was not updated."
      redirect_to cart_path
    end
  end
end
