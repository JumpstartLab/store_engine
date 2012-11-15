Fabricator(:category, :class_name => "Category") do
  id { sequence }
  name { Faker::Lorem.words(1).join(" ") + sequence.to_s }
end