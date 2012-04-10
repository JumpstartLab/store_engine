class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    product = Product.new(params[:product])
    product.categories << Category.find(params[:category].values)
    product.save
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])       
  end
end
