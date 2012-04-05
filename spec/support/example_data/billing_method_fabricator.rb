Fabricator(:billing_method, :class_name => BillingMethod) do
    name { Faker::Name.name }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip }
    state { Faker::Address.state_abbr }
    credit_card_number { (rand * 1e15).to_i }
    credit_card_expiration_date { (rand * 1e7).to_i }
end