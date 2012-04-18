# Allows searching on the website (including advanced search)
class SearchController < ApplicationController
  before_filter :require_admin, :only => [:new, :create]

  def index
    query = params[:q]
    search(query)
  end

  def new
    @search = AdvancedSearch.new
  end

  def create
    search = AdvancedSearch.new(params[:advanced_search])
    search.save()
    redirect_to "/search/#{search.id}"
  end

  def show
    search = AdvancedSearch.find(params[:id])
    @orders = search.find_orders()
  end

  private

  def search(query)
    value = "%#{query}%"
    @products = Product.where("name LIKE ? OR description LIKE ?", value, value)
  end

end
