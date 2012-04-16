Fabricator(:shipping_address, :class_name => ShippingAddress) do
    name { Faker::Name.name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip }
    state { Faker::Address.state_abbr }
    user_id { (rand * 1e7).to_i }
end