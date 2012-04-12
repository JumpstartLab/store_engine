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
    name "Andy"
    email "andy@andy.com"
    address "123 Andy Street, Andy, AK 200001"
    pay_type "Check"
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
    title 
    description "A fun and cheap toy!"
    price 2.45
  end
  
  factory :user do
    full_name "Andrew Glass"
    email "andy@livingsocial.com"
    admin false
    user_name "andy_glass"
    password "hungry"
  end
end