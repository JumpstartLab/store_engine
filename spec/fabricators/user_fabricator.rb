Fabricator(:user) do
  full_name 'Example User'
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  password 'asdfasdf'
  password_confirmation 'asdfasdf'
end