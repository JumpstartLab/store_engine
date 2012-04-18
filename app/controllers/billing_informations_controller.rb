class BillingInformationsController < ApplicationController

  def update
    current_user.billing_information.update_attributes(params[:billing_information])
    flash[:success] = "Billing information saved!"
    redirect_to_last_page
  end

  def create
    @billing_information = current_user.billinginformation.build(params[:billing_information])
    if @billing_information.save
      flash[:success] = "Billing information saved!"
      redirect_to_last_page
    else
      render 'root'
    end
  end
end
