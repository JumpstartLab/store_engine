class ActivationsController < ApplicationController

  def create
    activation = Activation.new(params[:product_id])
    activation.activate

    redirect_to admin_products_path
  end

end
