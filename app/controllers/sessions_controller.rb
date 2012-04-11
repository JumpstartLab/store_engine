class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email_address(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.has_pending_order?
        if session[:order_id]
          order = Order.find(session[:order_id])
          order.line_items.each do |li|
            li.update_attribute(:order_id, user.pending_order.id)
          end
        end
        session[:order_id] = user.pending_order.id
      end
      redirect_to root_url, :notice => "Welcome Back, #{user.full_name}"
    else
      render :new, :notice => 'Try again'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_url, :notice => 'Thanks for Visting'
  end

end
