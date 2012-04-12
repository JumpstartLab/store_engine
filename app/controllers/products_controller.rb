class ProductsController < ApplicationController

  # def retire
  #   product = Product.find(params[:id])
  #   product.retire
  #   redirect_to products_path
  #   # @product.update_attributes(:retired => true)
  # end

  def index
    @products = Product.active.all
    @categories = Category.all
  end

  def show
    @product = Product.find_by_id(params[:id])
    @categories = @product.categories
  end
  
end