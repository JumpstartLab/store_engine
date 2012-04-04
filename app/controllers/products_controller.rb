class ProductsController < ApplicationController

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


  #   def new
  #   @article = Article.new
  # end

  # def create
  #   article = Article.new(params[:article])
  #   article.save
  #   redirect_to article_path(article)
  # end
end
