class Admin::OrdersController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    @orders = Order.order(params[:sort])
  end

  def new
    @order = Order.new
    @cart = Cart.find(params[:cart_id])
  end

  def edit
  end

  def update
    order.update_attributes(params[:order])
    redirect_to admin_order_path(order)
  end

  def create
    order = Order.create_order_from_cart(cart, current_user)
    redirect_to admin_order_path(order)
  end

  helper_method :order
  helper_method :shipping_information
  helper_method :billing_information
  
private

    def order
      @order ||= Order.find(params[:id])
    end

    def admin_user
      redirect_to(root_path) && flash_error unless current_user.admin?
    end

    def flash_error
      flash[:error] = "You are not logged in as the correct user"
    end

    def shipping_information
      if current_user.shipping_information.nil?
        current_user.shipping_information = ShippingInformation.new
      else
        current_user.shipping_information
      end
    end

    def billing_information
      if current_user.billing_information.nil?
        current_user.billing_information = BillingInformation.new
      else
        current_user.billing_information
      end
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end  
end
