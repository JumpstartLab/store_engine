class CategoriesController < ApplicationController

  before_filter :lookup_category,
                :only => [:show]

  def index
    @categories = Category.all
  end

  def show
  end

  private

  def lookup_category
    @category = Category.find(params[:id])
  end
  
end
