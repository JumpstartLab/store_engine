class BillingInformationsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter :correct_user

  include BillingInformationHelper

  def new
    @billing_information = BillingInformation.new
  end

  def edit
    if BillingInformation.find_by_user_id(params[:id]).nil?
      @billing_information = BillingInformation.new
    else
      @billing_information = BillingInformation.find_by_user_id(params[:id])
    end
  end

  def show
  end

  def update
    billing_information.update_attributes(params[:billing_information])
    flash[:success] = "Shipping information updated!"
    redirect_back_to_order_or @billing_information
  end

  def create
    @billing_information = BillingInformation.new(params[:billing_information])
    if @billing_information.save
      flash[:success] = "Billing information saved!"
      redirect_back_to_order_or @billing_information
    else
      render 'new'
    end
  end

  helper_method :billing_information

  private 

    def billing_information
      @billing_information ||= BillingInformation.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) && flash_error unless current_user?(@user)
    end

    def flash_error
      flash[:error] = "You are not logged in as the correct user"
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
end
