class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:index, :status, :edit, :update]
  before_filter :require_logged_in, :except => [:track]
  before_filter :is_owner_or_admin, :only => [:show]

  def index
    status = Status.find_by_name(params[:status]) if params[:status]

    if not status
      @orders = Order.all
    else
      @orders = Order.where(:status_id => status.id)
    end

    @statuses = Status.all
    @order_count = Order.all.count
  end

  def edit
    @order = Order.find(params[:id], :include => :order_products)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.find_cart(@cart.id)
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    @order.save()
    
    flash[:notice] = 'Order has been updated'
    redirect_to order_path(@order)
  end

  def charge
    order = Order.process_cart(@cart.id)
    if order.user.update_address(params[:order][:user_attributes])
        order.charge(params[:order][:stripe_card_token])
        cookies[:cart_id] = nil
        redirect_to order_path(order), 
          :notice => "Congrats on giving us your money"
    else
      @order = order
      flash[:error] = "Address is invalid"
      render 'new'
    end
  end

  def status
    order = Order.find(params[:id])

    if order
      if order.status.pending?
        order.status = Status.find_or_create_by_name('cancelled')
        order.cancelled_at = DateTime.now
      elsif order.status.shipped?
        order.status = Status.find_or_create_by_name('returned')
        order.returned_at = DateTime.now
      elsif order.status.paid?
        order.status = Status.find_or_create_by_name('shipped')
        order.shipped_at = DateTime.now
      end

      order.save
    end

    redirect_to order_path(order), :notice => 'Status has been updated'
  end

  def track
    @order = Order.find_by_unique_url(params[:id])
    if not @order
      return redirect_to root_url, :notice => 'Invalid Order tracking code'
    end

    render 'show'
  end

  def my_orders
    st = params[:mq]
    if st
      orders = current_user
                .orders.joins(:products)
                .where('products.name LIKE ? or products.description LIKE ?', "%#{st}%", "%#{st}%")
                .uniq
    else
      orders = current_user.orders
    end

    status = Status.find_or_create_by_name("incomplete")
    @orders = orders - current_user.orders.where(:status_id => status.id)
  end

  private

  def is_owner_or_admin
    @order = Order.find_by_id(params[:id])
    if not current_user.admin and @order.user != current_user
      redirect_to root_url, :notice => 'That is not your order'
    end
  end

end
