class LineItemsController < ApplicationController

  load_and_authorize_resource

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    if product.retired == false
      @line_item = @cart.add_product(product.id)
      respond_to do |format|
        if @line_item.save
          format.html { redirect_to @line_item.cart}
          format.json { render json: @line_item,
                               status: :created,
                               location: @line_item }
        else
          format.html { render action: "new" }
          format.json { render json: @line_item.errors,
                               status: :unprocessable_entity }
        end
      end
    else
      redirect_to products_path, notice: "Cannot add inactive product to cart"
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to cart_path(current_cart),
                                  notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to cart_path(current_cart),
                                  notice: 'Quantity must be greater than 0' }
        format.json { render json: cart_path(current_cart),
                             status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(current_cart) }
      format.json { head :no_content }
    end
  end
end
