class ProductsController < ApplicationController
  def index
    @products = Product.apply_filter(params[:category_id])
    @categories = Category.all
  end

  def show
    session[:return_to] = request.fullpath
    @product = Product.find(params[:id])
  end
end
