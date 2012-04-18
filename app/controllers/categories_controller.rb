class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
  end

  helper_method :category

  private

  def category
    @category ||= Category.find(params[:id])
  end
  
end
