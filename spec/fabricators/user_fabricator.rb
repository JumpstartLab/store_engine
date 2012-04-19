Fabricator(:user, :class_name => "User") do
  password { "foo" }
  first_name { "Beverly" }
  last_name { "BOOM" }
  admin { false }
  email { "foo@foo.com" }
  salt { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
end
