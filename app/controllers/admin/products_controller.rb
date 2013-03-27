class Admin::ProductsController < ApplicationController
  before_filter :require_admin

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to admin_products_path, :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to admin_products_path, :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_url, :notice => "Successfully destroyed product."
  end

  def retire
    @product = Product.find(params[:id])
    if @product.retire
      redirect_to admin_products_path, :notice  => "Successfully updated category."
    else
      head 400
    end
  end

  def activate
    @product = Product.find(params[:id])
    if @product.activate
      redirect_to admin_products_path, :notice  => "Successfully updated category."
    else
      head 400
    end
  end
end
