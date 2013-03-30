class OrdersController < ApplicationController
  before_filter :require_login

  def new
    @order = Order.new
  end

  def index
    @orders = Order.find_all_by_user_id(current_user.id)
  end

  def show
    order = Order.find(params[:id])
    if current_user.id == order.user_id
      @order = Order.find(params[:id])
    else
      redirect_to account_orders_path
    end
  end

  def create
    @order = Order.create(status: 'pending', user_id: current_user.id)

    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product_id: product.id,
                               unit_price: product.price,
                               quantity: quantity)
    end

    if @order.valid?
      session[:cart] = {}
      redirect_to user_order_path(current_user, @order), :notice => "Successfully created order!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end

  def buy_now
    @order = Order.create(status: 'pending', user_id: current_user.id)

    product = Product.find(params[:order][:product_id])
    @order.order_items.create(product_id: product.id,
                              unit_price: product.price,
                              quantity: params[:order][:quantity])

    if @order.save
      redirect_to user_order_path(current_user, @order), :notice => "Successfully created order!"
    else
      redirect_to cart_path, :notice => "Checkout failed."
    end
  end
end
