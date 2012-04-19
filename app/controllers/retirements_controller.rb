class RetirementsController < ApplicationController

  def create
    retirement = Retirement.new(params[:product_id])
    retirement.retire

    redirect_to admin_products_path
  end

  def update
    activate = Retirement.new(params[:product_id])
    activate.activate

    redirect_to admin_products_path
  end

end