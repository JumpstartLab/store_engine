class Admin::CategoriesController < ApplicationController
  before_filter :require_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, :notice => "Successfully created category."
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to admin_categories_path, :notice  => "Successfully updated category."
    else
      render :action => 'edit'
    end
  end

  # def destroy
  #   @product = Product.find(params[:id])
  #   @product.destroy
  #   redirect_to admin_products_url, :notice => "Successfully destroyed product."
  # end
end
