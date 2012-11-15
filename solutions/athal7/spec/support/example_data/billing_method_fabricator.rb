Fabricator(:billing_method, :class_name => BillingMethod) do
    name { "primary" }
    street { "123 Abc St." }
    city { Faker::Address.city }
    zipcode { "20002" }
    state { Faker::Address.state_abbr }
    credit_card_number { ("1234" * 4 ) }
    month { "02" }
    year { "2014" }
    user_id { (rand * 1e7).to_i }
end