class ProductsController < ApplicationController
  before_filter :product, :only => [:show, :edit, :update]
  before_filter :categories, :only => [:new, :edit]

  def index
    products = Product.find(:all, :conditions => { :retired => false })
    rows = products.length / 5
    @product_rows = []
    rows.times do |row|
      @product_rows << products.pop(5)
    end

    if rows == 0 && products.length > 0
      @product_rows << products
    end
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
