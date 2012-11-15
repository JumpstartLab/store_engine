class DashboardController < ApplicationController
  before_filter :admin_authorize

  def show
    @orders = Order.all
    @categories = Category.all
    @products = Product.all
  end
end
