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

    order = Order.find(params[:billing][:order_id])
    order.update_attributes(:status => 'paid')
    session[:cart_id] = nil
    redirect_to order_path(order), :notice => "Order placed. Thank you!"
  end
end
