Fabricator(:user) do
  name { Faker::Lorem.words(1).first }
  email { Faker::Lorem.words(1).first + "@foobar.com" }
  password { "foobarrington" }
  password_confirmation { "foobarrington" }
end