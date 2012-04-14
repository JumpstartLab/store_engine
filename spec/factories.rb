FactoryGirl.define do
  factory :product do
    sequence(:title)  { |n| "New Product ##{n}" } 
    description Faker::Lorem.paragraph(sentence_count = 3)
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

  factory :cart do
  end

  factory :address do
    street_1 Faker::Address.street_address
    zip_code Faker::Address.zip_code
    city     Faker::Address.city
    state    Faker::Address.state_abbr
    association :user
  end
end