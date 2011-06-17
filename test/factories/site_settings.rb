Factory.define :site_setting do |a|
  a.title "Default Title"
  a.languages {|a| [a.association(:language, :code => "fr"), a.association(:language, :code => "en"), a.association(:language, :code => "de") ] }
end

Factory.define :language do |a|
  a.code "fr"
end