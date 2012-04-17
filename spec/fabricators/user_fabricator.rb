Fabricator(:user) do
  full_name 'Example User'
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password 'asdfasdf'
  password_confirmation 'asdfasdf'
  shipping_address 'Sample Shipping Address'
  billing_address 'Sample Billing Address'
end