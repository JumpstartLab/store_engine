class ProductRatingsController < ApplicationController
  def create
    p = params[:product_rating]
    product = Product.find(params[:product_id])
    product.product_ratings.new(:name => p[:name], 
                                   :body => p[:body], 
                                   :rating =>  p[:rating], 
                                   :user => current_user
                                  )
    if product.save
      redirect_to product, :notice => "Comment successfully added"    
    else
      flash[:error] = "There was an error with your comment"
      redirect_to product
    end
  end

  def destroy
  end
end
