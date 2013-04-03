FactoryGirl.define do

  factory :rating do
    title "Love it"
    body "You should buy it too!"
    stars 1
  end

  factory :category do
    title 'Dark Matter'
  end

  factory :sale do
    percent_off 50
    status 'active'
  end

  factory :order_item do
    product { FactoryGirl.build(:product) }
    order { FactoryGirl.build(:order) }
    unit_price 20.00
    selling_price 10.00
    percent_off 50
    quantity 3
  end

  factory :order do
    status 'pending'
  end

  factory :product do
    categories { [FactoryGirl.build(:category)] }
    title 'Itchy Sweater'
    description 'Hurts so good'
    price 12.99
    status 'active'
  end

  factory :user do
    full_name 'Raphael Weiner'
    email 'raphael@example.com'
    display_name 'raphweiner'
    password 'password'
    admin false
  end

  factory :admin, parent: :user do
    full_name 'Logan Sears'
    email 'logan@gmail.com'
    display_name 'lsears'
    password 'password'
    admin true
  end
end
