# Allows restful actions for the categories
class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products =
      @category.products.where(:active => 1).paginate(:page => params[:page])
    @categories = Category.all
  end

end
