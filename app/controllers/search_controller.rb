class SearchController < ApplicationController

  def index
    q = params[:q]
    search(q)
  end

  private

  def search(q)
    v = "%#{q}%"
    @products = Product.where("name LIKE ? OR description LIKE ?", v, v)
  end

end
