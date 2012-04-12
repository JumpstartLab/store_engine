class CategoriesController < ApplicationController
  before_filter :lookup_category, :only => [:destroy, :edit, :update, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, :notice => 'Category saved!'
    else
      render :new, :notice => "Didn't work."
    end
  end

  def edit

  end

  def show

  end

  def index
    @categories = Category.all
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to categories_path, :notice => "Updated successfully."
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, :notice => "Category deleted."
    end
  end

  private

  def lookup_category
    @category = Category.find(params[:id])
  end
  
end
