class Admin::ProductsController < ApplicationController
  before_filter :admin_or_redirect
  before_filter :product, :only => [:show, :edit, :update]
  before_filter :categories, :only => [:new, :edit]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    set_categories
    @product.save
    redirect_to products_path
  end

  def show  
  end

  def edit
  end

  def update
    @product.update_attributes(params[:product])
    set_categories
    redirect_to product_path(@product)
  end

  private

  def set_categories
    if params.has_key?(:category)
      @product.set_categories(params[:category].values)
    end
  end

  def product
    @product = Product.find(params[:id])
  end

  def categories
    @categories  = Category.all
  end
end
