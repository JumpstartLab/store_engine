class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @products = @category.products
  end

end
