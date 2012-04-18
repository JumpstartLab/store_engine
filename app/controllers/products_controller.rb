class ProductsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :destroy, :edit, :update]

  def index
    @products = Product.where(:active => 1).paginate(:page => params[:page])
    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @can_rate = can_rate(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    if @product.save()
      redirect_to product_path(@product), :notice => "Product created."
    else
      render 'new'
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path, :notice => "Product Removed"
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

private

  def can_rate(id) ## Users can only rate if they have purchased the product
    if current_user && current_user.products.find_by_id(id)
      true
    end
  end
  
end
