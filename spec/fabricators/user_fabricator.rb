Fabricator(:user) do
  name { Faker::Lorem.words(1).first }
  display_name { Faker::Lorem.words(1).first }
  email { Faker::Name.first_name + "@" + Faker::Name.last_name + ".com" }
  password { "foobarrington" }
  password_confirmation { "foobarrington" }
end