FactoryGirl.define do
  
  sequence :title do |n|
    "#{n} Yo-Yo"
  end

  sequence :email do |n|
    "andyglass#{n}@livingsocial.com"
  end

  sequence :username do |n|
    "#{n}andyglass"
  end

  factory :order do
    id 1
    name "Andy"
    email "andy@andy.com"
    address "123 Andy Street, Andy, AK 200001"
    pay_type "Check"
    user
  end

  factory :line_item do
    cart
  end

  factory :cart do
  end

  factory :order_item do
    order_id 1
  end

  factory :product do
    # id 1
    title "yo-yo"
    description "A fun and cheap toy!"
    price 2.45
    photo "http://photo.jpg"
  end

  factory :category do
    name "robots"
    id 1
  end
  
  factory :user do
    full_name "Andrew Glass"
    email "andy@livingsocial.com"
    admin false
    password "hungry"
  end

  factory :category_assignment do
    id 1
    product
    category
  end

end