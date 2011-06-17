Soit /^les médias suivants dans la base:$/ do |table|

  table.hashes.each do |media|
    Factory.create(:asset, :name => media["titre"])
  end
  
end

Alors /^je devrais voir (un|\d+) média/ do |nombre|
  nombre = 1 if nombre == "un"
  
  doc = Nokogiri::HTML.parse(@response.body)
  nb_assets = doc.css("table>tbody>tr").size
  
  assert_equal nombre.to_i, nb_assets
end

Lorsque /^je clique sur le lien pour supprimer un média$/ do
  click_link("supprimer", :method => :delete)
end
