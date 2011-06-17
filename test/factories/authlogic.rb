Factory.define :user do |u|
  u.email "franck@test.fr"
  u.password_salt { Authlogic::Random.hex_token }
  u.crypted_password {|s| Authlogic::CryptoProviders::Sha512.encrypt("mypassword" + s.password_salt) }
  u.persistence_token "6cde0674657a8a313ce952df979de2830309aa4c11ca65805dd00bfdc65dbcc2f5e36718660a1d2e68c1a08c276d996763985d2f06fd3d076eb7bc4d97b1e317"
  u.perishable_token { Authlogic::Random.friendly_token }
  u.active true
end