Fabricator(:user, :class_name => "User") do
  id { sequence }
  username { "admin" }
  display_name { "Admin Boom"}
  admin { true }
  email { "whatever@whatever.com" }
  #salt { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
  #activation_state { active }
end