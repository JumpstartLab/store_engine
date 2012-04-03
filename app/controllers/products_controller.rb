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
      product = Product.new(params[:product])
      product.save
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
