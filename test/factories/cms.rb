Factory.define :article do |a|
  a.title "Un article"
  a.association :category, :factory => :category
end

Factory.define :category do |a|
  a.name "root"
end