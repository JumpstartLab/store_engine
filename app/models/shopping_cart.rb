class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def add_item(product_id, quantity)
    product = Product.find(product_id)
    item = CartItem.new(:product => product, :quantity => quantity,
                        :price => product.price_string)
    cart_items << item
  end
end
