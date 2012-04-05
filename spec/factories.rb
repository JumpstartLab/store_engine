FactoryGirl.define do
  
  factory :order do
  end

  sequence :title do |n|
    "#{n} Yo-Yo"
  end

  factory :product do
    title 
    description "A fun and cheap toy!"
    price 2.45
  end
  
end