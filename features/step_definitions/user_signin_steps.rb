Soit /^je suis un méchant sur (.*)$/ do |page_name|
  visit path_to(page_name)
end

Soit /^un utilisateur dans la base$/ do
  Factory.build(:user).save_without_session_maintenance  
end

Soit /^je suis un visiteur créant un compte$/ do
  visit path_to("la page d'inscription")
  fill_in(:email, :with => "franck@test.fr")
  click_button("Inscription")
end

Lorsque /^je donne mon email$/ do
  fill_in(:email, :with => "franck@test.fr")
  click_button("Inscription")
end

Lorsque /^je clique sur le lien d'activation dans l'email$/ do
  visit_in_email("http://test.host")
end

Lorsque /^je définis un mot de passe$/ do
  fill_in("user[password]", :with => "mypassword")
  fill_in("user[password_confirmation]", :with => "mypassword")
  click_button("Activé")
end