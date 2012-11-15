class Admin::ProductsController < ApplicationController
  before_filter :require_login, :only => :new
  before_filter :admin?, :only => :new

  def index
    @products = Product.all.sort_by { |product| product.title}
  end

  def show
    @categories = Category.all
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.create(params[:product])
    redirect_to admin_product_path(product), :notice => "Product created."
  end

  def edit
    @categories = Category.all
    @product = Product.find(params[:id])
  end

  def update
    Product.find(params[:id]).update_attributes(params[:product])
    redirect_to admin_products_path
  end

  def retire_product
    product = Product.find(params[:product_id])
    product.retire
    notice = "Product #{product.title} retired."
    redirect_to admin_products_path, :notice => notice
  end
end
