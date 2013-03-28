FactoryGirl.define do
  factory :user do |f|
    f.full_name 'Raphael Weiner'
    f.email 'raphael@example.com'
    f.display_name 'raphweiner'
    f.password 'password'
    f.admin false
  end

  factory :admin, parent: :user do |f|
    f.full_name 'Logan Sears'
    f.email 'logan@gmail.com'
    f.display_name 'lsears'
    f.password 'password'
    f.admin true
  end
end
