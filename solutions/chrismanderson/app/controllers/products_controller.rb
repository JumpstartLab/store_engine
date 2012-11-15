class ProductsController < ApplicationController

  before_filter :admin_authorize,
                only: [:destroy, :edit, :update, :create, :new]

  def index
    if params[:search] && params[:search].length > 0
      @products = Product.active.find_by(params[:search])
      json_responder
    else
      @products = Product.active
      json_responder
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product), :notice => "Product created."
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to product_path(@product), :notice => "Product updated."
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, :alert => "Product deleted."
  end

  private

  def json_responder
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end
end
