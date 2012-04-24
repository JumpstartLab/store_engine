# Allows restful actions for orders + charging orders
class Admin::OrdersController < AdminController

  def index
    status = Status.find_by_name(params[:status]) if params[:status]

    if not status
      @orders = Order.active
    else
      @orders = Order.where(:status_id => status.id)
    end
    @statuses = Status.all
    @order_count = Order.all.size
  end

  def edit
    @order = Order.find(params[:id], :include => :order_products)
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    @order.save()

    flash[:notice] = 'Order has been updated'
    redirect_to order_path(@order)
  end

  def status
    order = Order.find(params[:id])
    order.next_status
    redirect_to order_path(order), :notice => 'Status has been updated'
  end

end
