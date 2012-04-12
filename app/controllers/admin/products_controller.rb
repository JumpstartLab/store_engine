class Admin::ProductsController < ApplicationController
  before_filter :admin_or_redirect

  def index
    @products = Product.all 
  end
end
