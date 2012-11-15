require 'date'

class OrdersController < ApplicationController
  before_filter :admin_or_not_found, :only => :update
  before_filter :logged_in_or_not_found, :only => [:index, :show]

  def index
    @orders = Order.where("user_id = ?", current_user)
  end

  def create
    status = Status.find_by_name("paid")
    shipping_address = current_user.shipping_address
    billing_address = current_user.billing_address
    @order = Order.new(:status => status, :user => current_user,
                       :shipping_address => shipping_address,
                       :billing_address => billing_address,
                       :status_updated_at => DateTime.now)
    cart.cart_items.each do |item|
      @order.order_items << OrderItem.new(:product => item.product,
                                          :price => item.price.to_s,
                                          :quantity => item.quantity)
    end

    @order.charge(current_user.transaction, cart.total.cents)

    if @order.save
      flash[:notice] = "Thank you for your order"
      cart.clear
      redirect_to order_path(@order)
    end
  end

  def show
    @order = Order.find(params[:id])
    @shipping_address = @order.shipping_address
    @billing_address = @order.billing_address

      if current_user.admin?
        status_name = @order.status.name
        if status_name == StoreEngine::Status::PENDING ||
           status_name == StoreEngine::Status::PAID
          render :template => "orders/admin_show"
        end
      elsif @order.user != current_user
        not_found
      end
  end

  def update
    @order = Order.find(params[:id])
    if params.key?(:status_update) then @order.update_status end
    if params.key?(:quantity)
      @order.update_quantities(params[:quantity])
    end
    redirect_to request.referer
  end

  private

  def logged_in_or_not_found
    unless logged_in?
      not_found
    end
  end
end
