class OrdersController < ApplicationController
  before_filter :require_login

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
