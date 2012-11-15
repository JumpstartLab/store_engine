class ProductsController < ApplicationController

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
  end

  helper_method :product

  private

  def product
    @product ||= Product.find(params[:id])
  end
end
