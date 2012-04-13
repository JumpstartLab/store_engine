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
  
  factory :user do
    full_name Faker::Name.name
    password "foo"
    username Faker::Name.first_name
    email Faker::Internet.email
  end
end