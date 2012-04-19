class Admin::ProductsController < ApplicationController
  before_filter :admin_or_not_found
  before_filter :product, :only => [:show, :edit, :update]
  before_filter :categories, :only => [:new, :edit]

  def index
    if params.has_key?(:retired)
      @products = Product.find(:all, :conditions => { :retired => true })
    else
      @products = Product.all
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    set_categories
    if @product.save
      flash[:notice] = "Product added"
    else
      flash[:notice] = "Failed to add product"
    end
    redirect_to admin_product_path(@product)
  end

  def show  
  end

  def edit
  end

  def update
    @product.update_attributes(params[:product])
    set_categories
    redirect_to admin_product_path(@product)
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
