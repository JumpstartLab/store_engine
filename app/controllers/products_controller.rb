class ProductsController < ApplicationController
  before_filter :lookup_product, :only => [:show, :edit, :destroy, :update]

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    product_params = params[:product]
    # product_params = params[:product].dup
    product_params.delete(:category_ids)
    product = Product.create(product_params)
    params[:product][:category_ids].each do |ci|
      ProductCategorization.create(
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
end
