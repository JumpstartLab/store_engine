Fabricator(:user, :class_name => "User") do
  id { sequence }
  username { "foo" }
  password { "foo" }
  first_name { "Beverly" }
  last_name { "BOOM" }
  admin { false }
  email { "whatever@whatever.com" }
  salt { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
end
