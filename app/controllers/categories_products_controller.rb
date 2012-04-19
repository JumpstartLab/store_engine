class CategoriesProductsController < ApplicationController

  def index
    @category = Category.find(params[:category_id])
    products = Category.find(params[:category_id]).products.find(:all,
                            :conditions => { :retired => false})
    rows = products.length / 5
    @product_rows = []
    rows.times do |row|
      @product_rows << products.pop(5)
    end
  end
end
