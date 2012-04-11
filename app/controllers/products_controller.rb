class ProductsController < ApplicationController

  # def retire
  #   product = Product.find(params[:id])
  #   product.retire
  #   redirect_to products_path
  #   # @product.update_attributes(:retired => true)
  # end

  def index
    @products = Product.active.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(params[:product])
    @categories = Category.all

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      @product.errors.full_messages.each do |msg|
        flash.now[:error] = msg
      end
      render 'new'
    end
  end

  def show
    @product = Product.find_by_id(params[:id])
    @categories = @product.categories
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    @product.update_attributes(params[:product])
    @product.update_categories(params[:categories][1..-1])
    redirect_to @product, notice: 'Product was successfully updated.'
  end
  
end