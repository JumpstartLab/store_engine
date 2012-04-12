class ProductsController < ApplicationController

  def index
    @products = Product.active.all
    @categories = Category.all
  end

  def show
    @product = Product.find_by_id(params[:id])
    @categories = @product.categories
  end
  
end