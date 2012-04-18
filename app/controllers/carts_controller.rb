class CartsController < ApplicationController

  load_and_authorize_resource

  def show
    @cart = Cart.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def new
    @cart = Cart.new
    respond_to do |format|
      format.html
      format.json { render json: @cart }
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart,
                                  notice: 'Cart was successfully created.' }
        format.json { render json: @cart,
                             status: :created,
                             location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors,
                             status: :unprocessable_entity }
      end
    end
  end


  def update
    @cart = Cart.find(params[:id])
    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart,
                                  notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors,
                             status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to products_path, notice: "Your cart is empty" }
      format.json { head :ok }
    end
  end
end
