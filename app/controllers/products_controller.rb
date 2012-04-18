class ProductsController < ApplicationController

  before_filter :authorize, only: [:edit, :update]
  before_filter :admin_authorize, only: [:destroy]
  
  def index
    if params[:search] && params[:search].length > 0
      @products = Product.find_by(params[:search])
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    product.save
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
end
