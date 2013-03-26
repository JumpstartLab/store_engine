FactoryGirl.define do
  factory :user do |f|
    f.full_name 'Raphael Weiner'
    f.email 'raphael@example.com'
    f.display_name 'raphweiner'
    f.password 'password'
    f.admin false
  end
end
