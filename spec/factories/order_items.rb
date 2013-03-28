FactoryGirl.define do

  # factory :product do
  #   title 'Itchy Sweater'
  #   description 'Hurts so good'
  #   price 12.99
  #   status 'active'

  #   factory :good_product do
  #     title 'Non-Itchy Sweater'
  #     description 'Hurts so good'
  #     price 12.99
  #     status 'active'
  #   end
  # end

  factory :order_item do |f|
    # f.association :product, :good_product
    f.product { FactoryGirl.build(:product) }
    f.order { FactoryGirl.build(:order) }
    f.unit_price { 12.99 }
    f.quantity 3
  end
end
