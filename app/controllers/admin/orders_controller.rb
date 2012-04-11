class Admin::OrdersController < ApplicationController

  before_filter :require_admin
  before_filter :find_order, only: [:cancel, :ship, :return]

  def index
    @count_report = Order.count_report
    if params[:status_filter]
      @orders = Order.where(status: params[:status_filter].downcase)
    else
      @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    quantities = params[:order_item_quantities]

    # TODO: This could probably factored out into Order
    # TODO: Should probably be in a transaction.
    quantities.each do |id, quantity|
      quantity = quantity.to_i
      item = @order.order_items.find(id)

      if quantity > 0
        item.quantity = quantity
        item.save!
      else
        item.destroy
      end
    end

    @order.status = params[:status]

    if @order.save
      redirect_to admin_order_path(@order)
    else
      render action: :edit
    end
  end

  def cancel
    if @order.status == "pending"
      @order.update_attributes(status: "cancelled")
    end
    return redirect_to admin_orders_path
  end

  def ship
    if @order.status == "pending"
      @order.update_attributes(status: "shipped")
    end
    return redirect_to admin_orders_path
  end

  def return
    if @order.status == "shipped"
      @order.update_attributes(status: "returned")
    end
    return redirect_to admin_orders_path
  end

  def find_order
    @order = Order.find(params[:id])
  end

end


