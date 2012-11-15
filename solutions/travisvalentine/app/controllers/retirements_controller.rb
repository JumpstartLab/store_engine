class RetirementsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    product.retire
    redirect_to admin_products_path
  end

end
