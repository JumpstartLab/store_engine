class CategoriesController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :update, :edit, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.where(:active => 1).paginate(:page => params[:page])
    @categories = Category.all
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, :notice => "Category created."
    else
      flash[:error] = "Create failed."
      render 'edit'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to categories_path, :notice => "Category updated."
    else
      flash[:error] = "Update Failed."
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path, :notice => "Category deleted."
  end

end
