Fabricator(:category) do
  name { Faker::Lorem.words(num = 1).join("") }
end