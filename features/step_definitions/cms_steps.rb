Soit /^les articles suivant dans la base:$/ do |table|
  
  table.hashes.each do |article|
    state = case article["status"]
    when "en cours"
      :pending
    when "publié"
      :published
    when "archivé"
      :archived
    else
      :pending
    end
    
    date = case article["date de création"]
    when "un jour"
      Time.now - 1.day
    when "deux jours"
      Time.now - 2.days
    else
      nil
    end
  
    art = Factory.build(:article, :title => article["titre"], :state => state, :created_at => date)
    unless article[:keywords].blank?
      art.keyword_list = article[:keyword]
    end
    art.save
  end
end

Soit /^les catégories suivantes dans la base:$/ do |table|
  table.hashes.each do |category| 
    cat = Factory.create(:category, :name => category["nom"])
    unless category["parent"].blank?
      cat.move_to_child_of Category.find_by_name(category["parent"])
    end
  end
end

Lorsque /^je clique sur le lien du dernier article crée$/ do
  article = Article.find(:first, :order => "created_at desc")
  click_link("article_#{article.id}")
end

Alors /^je devrais voir (un|\d+) article/ do |nombre|
  nombre = 1 if nombre == "un"
  
  doc = Nokogiri::HTML.parse(@response.body)
  nb_articles = doc.css("table>tbody>tr").size
  
  assert_equal nombre.to_i, nb_articles
end

Lorsque /^je clique sur le lien pour supprimer un article$/ do
  click_link("supprimer", :method => :delete)
end

Lorsque /^je clique sur le lien "([^\"]*)" pour modifier l'article$/ do |lien|
  click_link(lien, :method => :get)
end

Alors /^je devrais voir le titre "(.*)"$/ do |titre|
  assert_match /<h[0-9]+>#{titre}<\/h[0-9]+>/m, @response.body
end

Alors /^je devrais voir le status "([^\"]*)" dans le tableau des article$/ do |status|
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|
    assert_match /#{status}/, line.content
  end
end

Alors /^je devrais voir "([^\"]*)" sur (un|\d+) niveau/ do |categorie, niveau|
  niveau = 1 if niveau == "un"
  assert_match /#{categorie}/, @response.body
  pattern = '-&nbsp;'*niveau.to_i
  assert_match /#{}/, @response.body
end

Lorsque /^je clique sur le lien pour supprimer la catégorie "([^\"]*)"$/ do |category|
  cat = Category.find_by_name(category)
  
  within("#category_" + cat.id.to_s) do |scope|
    scope.click_link("supprimer", :method => :delete)
  end  
end

Lorsque /^je clique sur le lien "([^\"]*)" la catégorie "([^\"]*)"$/ do |link, category|
  cat = Category.find_by_name(category)
  
  within("#category_" + cat.id.to_s) do |scope|
    scope.click_link(link)
  end
end

Alors /^je ne devrais pas voir l'onglet "([^\"]*)"$/ do |onglet|
  value = false
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#adminMenu").each do |scope|
    value = true if (assert_no_match /#{onglet}/, scope.content)
  end
  doc.css("#adminSubMenu").each do |scope|
    value = true if (assert_no_match /#{onglet}/, scope.content)
  end
  return value
end

Alors /^je devrais voir l'onglet "([^\"]*)"$/ do |onglet|
  value = false
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("#adminMenu").each do |scope|
    value = true if scope.content =~ /#{onglet}/
  end
  doc.css("#adminSubMenu").each do |scope|
    value = true if scope.content =~ /#{onglet}/
  end
  return value
end

