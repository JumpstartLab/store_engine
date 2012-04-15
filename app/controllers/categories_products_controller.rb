class CategoriesProductsController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
  end
end
