Fabricator(:order) do
  billing_address_id    { rand(1..5) }
  shipping_address_id   { rand(1..5) }
  user_id               { rand(1..3) }
end