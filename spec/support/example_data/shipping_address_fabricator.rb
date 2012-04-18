Fabricator(:shipping_address, :class_name => ShippingAddress) do
    name { "primary" }
    street { "123 Abc St." }
    city { Faker::Address.city }
    zipcode { "20002" }
    state { Faker::Address.state_abbr }
    email_address { "test#{sequence}@test.com" }
    user_id { (rand * 1e7).to_i }
end