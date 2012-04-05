class Admin::ProductsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.name  = params[:product][:name]
    @product.price = params[:product][:price]

    if @product.save
      redirect_to :action => 'show', :id => @product
    else
      @products = Product.all
      render :action => 'edit'
    end
  end
end
