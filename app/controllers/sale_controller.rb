class SaleController < ApplicationController

  def index
    @sale_by_products = Sale.all
  end
end
