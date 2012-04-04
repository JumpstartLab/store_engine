class ProductsController < ApplicationController
  before_filter :lookup_product, :only => [:show, :edit, :destroy, :update]
  before_filter :lookup_categories

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    params[:product][:photo_url] = nil if params[:product][:photo_url] = ""
    product = Product.create(params[:product])
    params[:category_ids].each do |ci|
      ProductCategorizaton.create(
        product_id: product.id, category_id: ci )
    end
    redirect_to product_path(product)
  end

  def destroy
    Product.destroy(@product)
    redirect_to products_path
  end

  def edit
  end

  def update
    @product.update_attributes(params[:product])
    redirect_to product_path(@product)
  end

  private

  def lookup_product
    @product = Product.find(params[:id])
  end
  def lookup_categories
    @categories = Product.all.flat_map(&:categories)
  end
end
