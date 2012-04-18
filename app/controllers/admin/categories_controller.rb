class Admin::CategoriesController < ApplicationController
  # before_filter :admin_required
  
  def index
    @categories = Category.all
  end

  def show
  end

  def edit
  end

  def update
    category.update_attributes(params[:category])
    redirect_to admin_categories_path
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(params[:category])
    category.save
    redirect_to admin_categories_path
  end

  def destroy
    category.destroy
    redirect_to admin_categories_path
  end

  helper_method :category

  private

  def category
    @category ||= Category.find(params[:id])
  end
  
end
