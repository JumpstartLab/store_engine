class OrdersController < ApplicationController
  def index
    @orders = Order.find_all_by_user_id(params[:user_id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(status: 'pending', user: current_user)

    params[:cart].each do |product, quantity|
      order_item = OrderItem.new(product: product,
                                 price: product.price,
                                 quantity: quantity)
      @order.order_items << order_item
    end

    if @order.save
      redirect_to order_path(@order), :notice => "Successfully created order."
    else
      render :action => 'new'
    end
  end
end
