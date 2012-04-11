class ProductsController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_product, :only => [:show, :edit, :update]


  def index
    @cart = current_cart
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @product.update_attributes(params[:product])
    @product.save
    redirect_to products_path
  end


  def lookup_product
    @product = Product.find(params[:id])
  end
end
