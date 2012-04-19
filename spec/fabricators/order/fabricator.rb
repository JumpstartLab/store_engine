Fabricator(:order) do
  billing_address_id    { rand(5)+1 }
  shipping_address_id   { rand(5)+1 }
  user_id               { rand(3)+1 }
end