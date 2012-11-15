class Admin::ProductsController < ApplicationController
  before_filter :require_login
  before_filter :is_admin?

  def index
    @products = Product.active.all
    @retired_products = Product.retired.all
    @categories = Category.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.create(params[:product])
    @categories = Category.all

    if @product.save
      @product.update_categories(params[:categories][1..-1])
      redirect_to admin_product_path(@product),
        notice: 'Product was successfully created.'
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
    @categories = Category.all
    @product.update_attributes(params[:product])

    if @product.save
      @product.update_categories(params[:categories][1..-1])
      redirect_to admin_product_path(@product),
        notice: 'Product was successfully updated.'
    else
      @product.errors.full_messages.each do |msg|
        flash.now[:error] = msg
      end
      render 'edit'
    end
  end
end
