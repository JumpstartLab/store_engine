FactoryGirl.define do
  factory :product do
    sequence(:title)  { |n| "New Product ##{n}" } 
    description "Fantastic product"
    price 500 
  end

  factory :category do
    title "New Category"
  end

  factory :cart_item do
    quantity { rand(1..100) } 
  end
end