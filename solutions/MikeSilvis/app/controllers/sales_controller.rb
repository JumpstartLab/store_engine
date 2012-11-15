# Administrators can create sales
class SalesController < ApplicationController

  def index
    @sales = Sale.all
  end

  def show
    @sale = Sale.find(params[:id])
  end

end
