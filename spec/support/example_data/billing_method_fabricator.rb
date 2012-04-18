Fabricator(:billing_method, :class_name => BillingMethod) do
    name { "primary" }
    street { "123 Abc St." }
    city { Faker::Address.city }
    zipcode { "20002" }
    state { Faker::Address.state_abbr }
    credit_card_number { ("1234" * 4 ) }
    credit_card_expiration_date { ("1/4/2013") }
    user_id { (rand * 1e7).to_i }
end