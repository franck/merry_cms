Alors /^je devrais voir (un|\d+) utilisateurs avec le pattern "([^\"]*)"$/ do |nombre, pattern|
  nombre = 1 if nombre == "un"
  emails = []
  
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table").each do |table|      
    emails = table.content.scan(/#{pattern}/)
  end
  
  assert_equal nombre.to_i, emails.size
end

Alors /^je devrais voir le tableau d'utilisateurs suivant:$/ do |table|

  @table = []
  
  table.hashes.each do |user|
    @table << user["email"]
  end
  
  emails = []
  
  doc = Nokogiri::HTML.parse(@response.body)
  doc.css("table>tbody>tr").each do |line|      
    emails << line.content.match(/[\w.-]+@[\w.-]+\.[a-zA-Z]{2,5}/)[0]
  end
  
  assert_equal @table.size, emails.size
  
  for i in 0..emails.size-1
    assert_equal @table[i], emails[i]
  end
  
end


Lorsque /^je test le filtrage avec une chaine qui ne veut rien dire$/ do
  fill_in("filtrer", :with => "value") 
end
