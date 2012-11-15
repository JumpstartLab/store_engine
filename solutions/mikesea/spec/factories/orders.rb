# Read about factories at http://github.com/thoughtbot/factory_girl

# FactoryGirl.define do
#   factory :order_product do
#     product_id 1
#     order_id 1
#     price 1500
#     quantity 1
#   end
# end


FactoryGirl.define do
  factory :order do
    user_id 1
  end

  factory :order_product do
    product_id 1
    price 1500
    quantity 1
  end

end

# FactoryGirl.define do
#   factory :order do
#     user_id 1
#     before_create do |o|
#       Factory(:order_product, :order => o)
#     end
#   end

#   factory :order_product do
#     product_id 1
#     order_id 1
#     price 1500
#     quantity 1
#   end

# end

