class RetirementsController < ApplicationController

  def create
    # product = Product.find(params[:id])
    # product.retire
    retirement = Retirement.new(params[:product_id])
    retirement.retire

    redirect_to admin_products_path
    # @product.update_attributes(:retired => true)
  end

end