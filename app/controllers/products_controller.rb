class ProductsController < ApplicationController
  def index
    @products = Product.apply_filter(params[:category_id])
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
