class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(params[:product])

    redirect_to @product, notice: 'Product was successfully created.'
  end

  def show
    @product = Product.find_by_id(params[:id])
    @categories = @product.categories
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    @product.update_categories(params[:categories][1..-1])
    redirect_to @product, notice: 'Product was successfully updated.'
  end

end
