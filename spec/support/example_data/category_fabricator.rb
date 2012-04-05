Fabricator(:category, :class_name => Category) do
  name { Faker::Name.name }
end