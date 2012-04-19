class ShippingInformationsController < ApplicationController

  def update
    user_shipping = current_user.shipping_information
    user_shipping.update_attributes(params[:shipping_information])
    flash[:success] = "Shipping information saved!"
    redirect_to_last_page
  end

  def create
    user_shipping = current_user.shipping_information
    @shipping_information = user_shipping.build(params[:shipping_information])
    if @shipping_information.save
      flash[:success] = "Shipping information saved!"
      redirect_to_last_page
    else
      render 'root'
    end
  end
end
