class ProductsController < ApplicationController

  before_filter :lookup_product, :only => [:show, :edit, :destroy, :update]
  def index
    @products = Product.all
  end

  def show
  end

  def destroy
    @product.destroy
    redirect_to products_path, :flash => {:success => "Product has been deleted."}
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    product.save
    redirect_to product_path(product), :notice => "Product has been created."
  end

  def edit
  end

  def update
    @product.update_attributes(params[:product])
    @product.save
    redirect_to product_path(@product), :notice => "Product has been edited."
  end

  def lookup_product
    @product = Product.find(params[:id])
  end
end
