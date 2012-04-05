Fabricator(:user, :class_name => "User") do
  id { sequence }
  username { "admin" }
  password { "admin" }
  display_name { "Admin Boom"}
  admin { true }
  email { "whatever@whatever.com" }
  salt { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
  after_create { |user| user.shopping_cart = Fabricate(:shopping_cart)}
end
