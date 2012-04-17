FactoryGirl.define do
  factory :product do
    sequence(:title)  { |t| "Title #{t}" }
    sequence(:description) { |d| "product_#{d}"}  
    price { rand(10000) }
    photo "http://portfolio.adigitalnative.com/style/images/th7.jpg"
    category_ids nil
    retired false
  end

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end