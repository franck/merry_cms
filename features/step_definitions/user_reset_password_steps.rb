Lorsque /^je donne un email valide$/ do
  fill_in("email", :with => "franck@test.fr")
  click_button("Réinitialisez mon mot de passe")
end


Lorsque /^je mets à jour mon mot de passe$/ do
  fill_in("user[password]", :with => "newpassword")
  fill_in("user[password_confirmation]", :with => "newpassword")
  click_button("Modifiez mon mot de passe et connectez moi")
end


Lorsque /^je donne un email qui n'existe pas$/ do
  fill_in("email", :with => "bademail@test.fr")
  click_button("Réinitialisez mon mot de passe")
end

Lorsque /^je clique sur le lien de réinilisation dans l'email$/ do
  open_email(current_email_address)
  visit_in_email("http://test.host")
end

Lorsque /^je demande la réinitilisation de mon mot de passe$/ do
  visit path_to("la page de réinitialisation du mot de passe")
  Lorsque %{je donne un email valide}
  Lorsque %{je clique sur le lien de réinilisation dans l'email}
end

Lorsque /^je laisse le mot de passe vide$/ do
  fill_in("user[password]", :with => "")
  fill_in("user[password_confirmation]", :with => "")
  click_button("Modifiez mon mot de passe et connectez moi")
end