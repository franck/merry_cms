Lorsque /^je renseigne le formulaire d'inscription avec de bons identifiants$/ do
  fill_in("user_session[email]", :with => "franck@test.fr")
  fill_in("user_session[password]", :with => "mypassword")
  click_button("s'identifier")
end

Alors /^je devrais voir le lien "(.*)"$/ do |text|
  assert_match /#{text}/m, @response.body
end

Lorsque /^je donne un email qui n'est pas dans la base$/ do
  fill_in("user_session[email]", :with => "bademail@test.fr")
  fill_in("user_session[password]", :with => "mypassword")
  click_button("s'identifier")
end

Lorsque /^je donne un mauvais mot de passe$/ do
  fill_in("user_session[email]", :with => "franck@test.fr")
  fill_in("user_session[password]", :with => "badpassword")
  click_button("s'identifier")
end

