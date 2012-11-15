class ProductsController < ApplicationController
  load_and_authorize_resource
  before_filter :lookup_product, :only => [:show, :edit, :update]


  def index
    @cart = current_cart
    @products = Product.all
  end

  def show
    @badge_html = @product.badge_html
    @order = Order.new
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
    if @product.retired
      @product.line_items.map(&:destroy)
    end
    redirect_to product_path(@product)
    flash.now.alert = "Product has been updated"
  end

  def lookup_product
    @product = Product.find(params[:id])
  end
end
