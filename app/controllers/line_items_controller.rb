class LineItemsController < ApplicationController

  load_and_authorize_resource

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    if product.retired == false
      @line_item = @cart.add_product(product.id)
      if @line_item.save
        redirect_to @line_item.cart
      else
        render action: "new"
      end
    else
      redirect_to products_path, notice: "Cannot add inactive product to cart"
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    if @line_item.update_attributes(params[:line_item])
      redirect_to cart_path(current_cart), notice: 'Item was successfully updated.'
    else
      redirect_to cart_path(current_cart), notice: 'Quantity must be greater than 0'
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(current_cart)
  end
end
