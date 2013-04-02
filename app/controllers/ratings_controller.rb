class RatingsController < ApplicationController
  before_filter :require_login

  def new
    @rating = Rating.new
    @product = Product.find(params[:product_id])
  end

  def create
    params[:rating].merge!(product_id: params[:product_id], user_id: current_user.id)
    @rating = Rating.new(params[:rating])
    @product = Product.find(params[:product_id])
    if @rating.save
      redirect_to product_path(@product), :notice => "Successfully created rating."
    else
      render :action => 'new', :notice  => "Rating creation failed."
    end
  end

  def edit
    @rating = Rating.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  def update
    @product = Product.find(params[:product_id])
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(params[:rating])
      redirect_to admin_path, :notice  => "Successfully updated rating."
    else
      render :action => 'edit', :notice  => "Update failed."
    end
  end
end
