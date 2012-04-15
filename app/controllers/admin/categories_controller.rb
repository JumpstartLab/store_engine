class Admin::CategoriesController < ApplicationController
  before_filter :admin?

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(params[:category])
    category.save
    redirect_to admin_categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update_attributes(params[:category])
    @category.save
    redirect_to admin_categories_path
  end
end
