class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def two_click_order
    cu = current_user
    if cu && !cu.billing_address.blank? && !cu.shipping_address.blank?
      @order = current_user.orders.create!(status: 'pending')
      @order.update_attributes(billing_address: current_user.billing_address, 
        shipping_address: current_user.shipping_address)
      @order.order_items.create(product_id: Product.find(params[:product_id]),
        quantity: 1)
      redirect_to order_path(@order)
    else
      flash[:alert] = "You must be signed in and have billing and shipping
                        address information on file."
      return redirect_to root_path
    end
  end
end
