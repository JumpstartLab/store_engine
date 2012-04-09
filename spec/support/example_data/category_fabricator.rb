Fabricator(:category, :class_name => Category) do
  name { Faker::Name.first_name }
end