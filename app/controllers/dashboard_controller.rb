class DashboardController < ApplicationController
  before_filter :require_admin, :needed_resources

  def index
  end

private

  def needed_resources
    @products = Product.all
    @categories = Category.all      
    #@search = AdvancedSearch.new
  end

end
