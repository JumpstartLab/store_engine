#gaming the system
class CartsController < ApplicationController

  load_and_authorize_resource

  def show
    @cart = Cart.find(params[:id])
  end

  def new
    @cart = Cart.new
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])
    react_to_save_cart_html(@cart.save)
  end

  def update
    @cart = Cart.find(params[:id])
    save_result = @cart.update_attributes(params[:cart])
    react_to_update_cart_html(save_result)
  end

  def destroy
    current_cart.destroy
    session[:cart_id] = nil
    redirect_to products_path, notice: "Your cart is empty"
  end

private

  def react_to_save_cart_html(result)
    if result
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render action: "new"
    end
  end

  def react_to_update_cart_html(result)
    if result
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render action: "edit"
    end
  end
end
