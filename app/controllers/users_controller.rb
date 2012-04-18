class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        redirect_back_or_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

  def create_billing
    current_user.add_credit_card(params[:credit_card])
    current_user.add_address(params[:address])
    redirect_to orders_path, :notice => "Order placed. Thanks bitches!"
  end
end
