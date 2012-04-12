class CategoriesController < ApplicationController
  def index
    @products = Product.all
  end

  # def filter_by_category
  #   @products = Product.find_all_by(params[:category])
  # end
end
