class CategoriesProductsController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
    @products = Category.find(params[:category_id]).products.find(:all,
                                     :conditions => { :retired => false})
  end
end
