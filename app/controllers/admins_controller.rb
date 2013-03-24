class AdminsController < ApplicationController
  def login
  end

  def dashboard
  end

  def products
    @products = Product.all
  end

  def categories
    @categories = Category.all
  end
end
