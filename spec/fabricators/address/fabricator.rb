Fabricator(:address) do
  street        { Faker::Address.street_name }
  street_two    { Faker::Address.secondary_address }
  city          { Faker::Address.city }
  state         { Faker::Address.state_abbr }
  country       { Faker::Address.country }
  zipcode       { Faker::Address.zip_code }
  phone_number  { Faker::PhoneNumber.phone_number }
end
