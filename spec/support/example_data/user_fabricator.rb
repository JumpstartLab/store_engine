Fabricator(:user, :class_name => User) do
  email_address { Faker::Internet.email }
  full_name { Faker::Name.name }
  display_name { Faker::Name.first_name }
  password { "test" }
  password_confirmation { "test" }

end