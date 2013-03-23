class AdminsController < ApplicationController
  def login
  end

  def dashboard
  end

  def products
    @products = Product.all
  end

  def categories
  end
end
