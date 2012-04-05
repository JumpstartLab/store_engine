class ShoppingCartController < ApplicationController

  def show
    cart = current_user.shopping_cart
    @cart_items = cart.cart_items
  end

  def update
    # POST from products => quantity, price, product id
    cart = ShoppingCart.new
    cart.add_item(product_id, quantity, price)
    redirect_to shopping_cart_path
    # cart = ShoppingCart.find(1)
    # order_product = OrderProduct.new
    # order_product.product = Product.find(params[:id])
    # cart.order_products << order_product
    # cart.save
    # redirect_to shopping_cart_index_path
  end

end
