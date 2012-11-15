# == Schema Information
#
# Table name: orders
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  status     :string(255)
#  address_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Cart < Order
  def add_product_by_id(product_id)
    add_product(Product.find(product_id))
  end
end
