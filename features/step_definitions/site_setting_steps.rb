Soit /^le site est correctement configuré$/ do
  Factory.create(:site_setting)
end

Soit /^le site est en language "([^\"]*)"$/ do |langue|
  visit "/#{langue}/home"
end


Lorsque /^je coche la langue "([^\"]*)"$/ do |langue|
  within("#language_#{langue}") do 
    check("languages[]")
  end
end

Lorsque /^je décoche la langue "([^\"]*)"$/ do |langue|
  within("#language_#{langue}") do 
    uncheck("languages[]")
  end
end