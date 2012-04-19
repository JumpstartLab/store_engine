class BillingInformationsController < ApplicationController

  def update
    billing_info = current_user.billing_information
    billing_info.update_attributes(params[:billing_information])
    flash[:success] = "Billing information saved!"
    redirect_to_last_page
  end

  def create
    billing_info = current_user.billinginformation
    @billing_information = billing_info.build(params[:billing_information])
    if @billing_information.save
      flash[:success] = "Billing information saved!"
      redirect_to_last_page
    else
      render 'root'
    end
  end
end
