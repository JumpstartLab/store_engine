class Admin::ProductsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin

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
    @product = Product.new(params[:product], as: :admin)

    if @product.save
      redirect_to [:admin, @product]
    else
      render :action => :new
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product], as: :admin)
      redirect_to :action => 'show', :id => @product
    else
      @products = Product.all
      render :action => 'edit'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def retire
    @product = Product.find(params[:id])
    @product.update_attribute(:retired, true)

    redirect_to :back
  end

  def unretire
    @product = Product.find(params[:id])
    @product.update_attribute(:retired, false)

    redirect_to :back
  end
end
