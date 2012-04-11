class ProductsController < ApplicationController
  before_filter :require_login, :only => :new
  before_filter :admin?, :only => :new

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(params[:product])
    redirect_to products_path,
      :notice => "Product created."
  end
end
