FactoryGirl.define do
  factory :product do |f|
    f.title 'Itchy Sweater'
    f.description 'Hurts so good'
    f.price 12.99
    f.status 'active'
  end
end
