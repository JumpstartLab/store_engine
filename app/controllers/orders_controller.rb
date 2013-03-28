class OrdersController < ApplicationController
  before_filter :require_login

  def new
    @order = Order.new
  end

  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(status: 'pending', user_id: current_user.id)

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(product_id: product.id,
                               unit_price: product.price,
                               quantity: quantity)
    end

    if @order.save
      session[:cart] = {}
      redirect_to user_order_path(current_user, @order), :notice => "Successfully created order!"
    else
      redirect_to cart_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
