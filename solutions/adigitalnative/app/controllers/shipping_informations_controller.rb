class ShippingInformationsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  # before_filter :correct_user

  include ShippingInformationHelper

  def new
    @shipping_information = ShippingInformation.new
  end

  def edit
    if ShippingInformation.find_by_user_id(params[:id]).nil?
      @shipping_information = ShippingInformation.new
    else
      @shipping_information = ShippingInformation.find_by_user_id(params[:id])
    end
  end

  def show
  end

  def update
    shipping_information.update_attributes(params[:shipping_information])
    flash[:success] = "Shipping information updated!"
    redirect_back_to_order_or @shipping_information
  end

  def create
    @shipping_information = ShippingInformation.new(params[:shipping_information])
    if @shipping_information.save
      flash[:success] = "Shipping information saved!"
      redirect_back_to_order_or @shipping_information
    else
      render 'new'
    end
  end

  helper_method :shipping_information

  private 

    def shipping_information
      @shipping_information ||= ShippingInformation.find(params[:id])
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(current_user.id) #|| User.find(params[:shipping_information][:user_id])
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
