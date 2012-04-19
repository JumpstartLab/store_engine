class Admin::ProductsController < ApplicationController
  before_filter :require_login, :only => :new
  before_filter :admin?, :only => :new

  def index
    @products = Product.all.sort_by { |product| product.title}
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(params[:product])
    redirect_to admin_products_path, :notice => "Product created."
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    Product.find(params[:id]).update_attributes(params[:product])
    redirect_to admin_products_path
  end
end
