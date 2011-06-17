Alors /^je vais créer une catégorie en "([^\"]*)"$/ do |langue|
  
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#select_language").each do |line|
    assert_match /#{langue}/, line.content
  end
  
end

Alors /^"([^\"]*)" devrait être traduite en "([^\"]*)"$/ do |categorie, langue|
  
  cat = Category.find_by_name(categorie)

  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#category_" + cat.id.to_s).each do |line|
    assert_match /#{langue}.png/, line.to_html
  end

end


Alors /^"([^\"]*)" devrait être traduit en "([^\"]*)"$/ do |article, langue|
  art = Article.find_by_title(article)

  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("tr#article_" + art.id.to_s + "_" + langue).each do |line|
    assert_match /#{langue}.png/, line.to_html
  end
end



Alors /^"([^\"]*)" ne devrait pas être traduit en "([^\"]*)"$/ do |article, langue|
  art = Article.find_by_title(article)

  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("tr#article_" + art.id.to_s + "_" + langue).each do |line|
    assert_no_match /#{langue}.png/, line.to_html
  end
end


Alors /^l'article devrait exister en "([^\"]*)"$/ do |langue|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#article_info").each do |line|
    assert_match /#{langue}.png/, line.to_html
  end
end

Alors /^l'article ne devrait pas exister en "([^\"]*)"$/ do |langue|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#article_info").each do |line|
    assert_no_match /#{langue}.png/, line.to_html
  end
end
