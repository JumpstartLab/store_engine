FactoryGirl.define do
  factory :user do 
    sequence(:display_name) { |n| "foo#{n}" }
    password "foobar"
    name "foo"
    email { "#{display_name}@example.com" }
    permission 1

    factory :admin do
      permission 9
    end
  end
  
  factory :status do
    name "shipped"
  end

  factory :order do
    user
    status
  end

  factory :product_rating do
    body "hello"
    name "AWESOME PRODUCT"
    rating 4
  end

  factory :product do
    sequence(:name) { |n| "product#{n}" }
    description "yummy foo"
    price_in_cents 100
  end

end