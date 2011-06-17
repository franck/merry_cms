Soit /^je suis identifié comme "([^\"]*)"$/ do |role|
  Factory.create(:site_setting)
  user = Factory.build(:user)
  user.save_without_session_maintenance
  user.has_role!(role)
  
  visit path_to("la page d'identification")
  fill_in("user_session[email]", :with => user.email)
  fill_in("user_session[password]", :with => "mypassword")
  click_button("s'identifier")
end

Soit /^un administrateur$/ do
  user = Factory.build(:user)
  user.save_without_session_maintenance
  user.has_role!("admin")
end

Soit /^3 utilisateurs dans la base$/ do
  user = Factory.create(:user, :email => 'gerard@test.fr', :persistence_token => 'a2c5d3a5031bb6ec1c17ca89b5a675678adb4ea502776d4d56f6a86e4be3cfa363cc2b5cbaac8fe9a3c46c18fd1a6f7db2959f39a54291f5a65ac18ad6184724')
  user.save_without_session_maintenance
  
  user = Factory.create(:user, :email => 'robert@test.fr', :persistence_token => 'd99f2b45dded2a02b219afecf1d896036462bdd0e67374c593affc69eabe0792a247027a1f88d193d34ed890a67536f642bd6f4c7f190f5aba8e3020a1ff0bf1')
  user.save_without_session_maintenance
end

Alors /^je devrais voir (un|\d+) utilisateurs$/ do |nombre|
  nombre = 1 if nombre == "un"
  emails = []
  
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table").each do |table|      
    emails = table.content.scan(/@test.fr/)
  end
  
  assert_equal nombre.to_i, emails.size  
end

Soit /^je suis identifié en tant que "([^\"]*)"$/ do |email|
  Factory.create(:site_setting)
  visit path_to("la page d'identification")
  fill_in("user_session[email]", :with => email)
  fill_in("user_session[password]", :with => "mypassword")
  click_button("s'identifier")
end

Alors /^je devrais voir le formulaire de création$/ do
  assert_select "form", true
end

Alors /^je devrais voir tous les rôles disponibles$/ do
  assert_match /administrateur/m, @response.body
end

Lorsque /^je remplis le formulaire avec des valeurs correctes$/ do
  fill_in("user[email]", :with => "franck@test.fr")
  fill_in("user[password]", :with => "mypassword")
  fill_in("user[password_confirmation]", :with => "mypassword")
  click_button("Ajouter")
end


Alors /^je devrais voir uniquement l'utilisateur "([^\"]*)"$/ do |arg1|
  assert_match /admin/, @response.body
  assert_no_match /franck/, @response.body
end

Alors /^je ne devrais pas pouvoir supprimer un administrateur$/ do
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|      
    if line.content =~ /administrateur/
      line.should_not have_selector("td>a", :content => "Supprimer")
    end
  end
end

Lorsque /^je remplis le formulaire en cochant le role administrateur$/ do
  fill_in("user[email]", :with => "franck@test.fr")
  fill_in("user[password]", :with => "mypassword")
  fill_in("user[password_confirmation]", :with => "mypassword")
  check("roles[]")
  click_button("Ajouter")
end

Alors /^je devrais voir le role "([^\"]*)" pour l'utilisateur "([^\"]*)"$/ do |role, email|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|      
    if line.content =~ /#{email}/
      assert_match /#{role}/, line.content
    end
  end
end

Soit /^les personnes suivantes dans la base$/ do |table|
  table.hashes.each do |user|
    u = Factory.build(:user, :email => user["email"], :persistence_token => user[:email])
    u.has_role!(user["roles"])
    if user["active"] == "false"
      u.desactivate
    end
    u.save_without_session_maintenance
  end
end

Lorsque /^je clique sur le lien "([^\"]*)" pour l'utilisateur "([^\"]*)"$/ do |link, email|
  user = User.find_by_email(email)
  within("#user_#{user.id}") do 
    click_link(link)
  end
end

Lorsque /^je coche le role "([^\"]*)"$/ do |role|
  @response.body.should have_selector("li", :content => role) do 
    check("roles[]")
  end
end

Alors /^l'utilisateur "([^\"]*)" devrait être actif$/ do |email|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|      
    if line.content =~ /#{email}/
      assert_match /oui/, line.content
    end
  end
end

Alors /^l'utilisateur "([^\"]*)" ne devrait pas être actif$/ do |email|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|      
    if line.content =~ /#{email}/
      assert_match /non/, line.content
    end
  end
end

Alors /^l'utilisateur "([^\"]*)" devrait pouvoir être activer/ do |email|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|
    if line.content =~ /#{email}/
      assert_match /(?!dés)activer/, line.content
    end
  end
end

Lorsque /^je clique sur le lien pour supprimer un utilisateur$/ do
  click_link("supprimer", :method => :delete)
end
