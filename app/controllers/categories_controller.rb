class CategoriesController < ApplicationController
  def show
    id = params[:id]
    @category = Category.find(id)
    @products = ProductCategory.find_all_by_category_id(id).map(&:product)
  end

  def index
    @categories = Category.all.sort_by { |category| category.name}
  end
end
