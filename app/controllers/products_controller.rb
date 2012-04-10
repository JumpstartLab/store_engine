class ProductsController < ApplicationController

  before_filter :authorize, only: [:edit, :update]
  before_filter :admin_authorize, only: [:destroy]
  
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(params[:product])
    product.save
    redirect_to products_path
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    redirect_to product_path(@product)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end


  #   def new
  #   @article = Article.new
  # end

  # def create
  #   article = Article.new(params[:article])
  #   article.save
  #   redirect_to article_path(article)
  # end
end
