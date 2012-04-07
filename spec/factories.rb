FactoryGirl.define do
  factory :user do 
    sequence(:display_name) { Faker::Name.name }
    password "foobar"
    name "foo"
    sequence(:email) { |n| "display_name#{n}@example.com"}
    permission 1

    factory :admin do
      permission 9
    end
  end
  factory :cart do
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

  factory :category do
    sequence(:name) { |n| "category#{n}" }
  end

end