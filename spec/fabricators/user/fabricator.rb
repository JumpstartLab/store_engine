Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  password { Faker::Lorem.words(num = 1) }
  admin { false }
  display_name { Faker::Lorem.words(num = 2).join("") }
end