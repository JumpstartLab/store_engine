class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    product.update_attributes(params[:product])
    redirect_to product_path(product)
  end

  def destroy
    product.destroy
    redirect_to products_path
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    product.save
    redirect_to product_path(product)
  end

  helper_method :product

  private

  def product
    @product ||= Product.find(params[:id])
  end
end
