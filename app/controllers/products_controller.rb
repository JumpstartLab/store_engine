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
    if params.has_key?(:category)
      product.categories << Category.find(params[:category].values)
    end
    product.save
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])       
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    product = Product.find(params[:id])
    product.update_attributes(params[:product])
    if params.has_key?(:category)
      product.categories << Category.find(params[:category].values)
    end
    redirect_to product_path(product)
  end
end