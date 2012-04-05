class ShoppingCart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def add_item(product_id, quantity, price)
    product = Product.find(product_id)
    item = CartItem.new(:product => product, :quantity => quantity,
                        :price => price)
    cart_items << item
  end
end
