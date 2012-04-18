class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.all
  end

  def two_click_order
    cu = current_user
    if cu && !cu.billing_address.blank? && !cu.credit_card.blank?
      @order = current_user.orders.create!(status: 'pending',
        billing_address: current_user.billing_address,
        shipping_address: current_user.shipping_address,
        email_address: current_user.email,
        credit_card: current_user.credit_card)
      @order.order_items.create(product_id: Product.find(params[:product_id]),
        quantity: 1)
      redirect_to order_path(@order)
    else
      flash[:alert] = "You must be signed in and have billing information
       on file to two-click order."
      return redirect_to root_path
    end
  end
end
