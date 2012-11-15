class ActivationsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    product.activate
    redirect_to admin_products_path
  end

end
