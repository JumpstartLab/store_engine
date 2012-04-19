class UserSessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to :root
    else
      @user = User.new
    end
  end

  def create
    back_to_cart = session[:back_to_cart]
    respond_to do |format|
      anonymous_cart = cart
      if user = login(params[:email],params[:password])
        cart.merge_cart_items(anonymous_cart)
        format.html do
          if back_to_cart
            if user.billing_address.nil?
              redirect_to new_billing_address_path
            else
              redirect_to order_summary_path
            end
          else
            redirect_back_or_to(:root, :notice => 'Login successful.')
          end
        end
        format.xml { render :xml => user,
                     :status => :created, :location => user }
      else
        format.html { flash.now[:alert] = "Login failed.";
                      render :action => "new" }
        format.xml { render :xml => user.errors,
                     :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to(:root, :notice => 'Logged out!')
  end
end
