Fabricator(:category) do
  name Faker::Name.first_name + sequence.to_s
end
