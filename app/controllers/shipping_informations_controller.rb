class ShippingInformationsController < ApplicationController

  def update
    current_user.shipping_information.update_attributes(params[:shipping_information])
    flash[:success] = "Shipping information saved!"
    redirect_to user_path(current_user)
  end

  def create
    @shipping_information = current_user.shipping_information.build(params[:shipping_information])
    if @shipping_information.save
      flash[:success] = "Shipping information saved!"
      redirect_to user_path(current_user)
    else
      render 'root'
    end
  end
end
