require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

# Commonly used webrat steps
# http://github.com/brynary/webrat

Soit /^je suis sur (.+)$/ do |page_name|
  visit path_to(page_name)
end

Lorsque /^je vais à (.+)$/ do |page_name|
  visit path_to(page_name)
end

Lorsque /^je vais sur (.+)$/ do |page_name|
  visit path_to(page_name)
end

Lorsque /^je clique sur "([^\"]*)"$/ do |button|
  click_button(button)
end

Lorsque /^je suis "([^\"]*)"$/ do |link|
  click_link(link)
end

Lorsque /^je clique sur le lien "([^\"]*)"$/ do |link|
  click_link(link, :method => :get)
end

Lorsque /^je remplis "([^\"]*)" avec "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value) 
end

Lorsque /^je sélectionne "([^\"]*)" dans "([^\"]*)"$/ do |value, field|
  val = Regexp.new(value)
  select(val, :from => field) 
end

# Use this step in conjunction with Rail's datetime_select helper. For example:
# Lorsque I select "December 25, 2008 10:00" as the date and time 
Lorsque /^je sélectionne "([^\"]*)" comme date et heure$/ do |time|
  select_datetime(time)
end

# Use this step Lorsque using multiple datetime_select helpers on a page or 
# you want to specify which datetime to select. Soit the following view:
#   <%= f.label :preferred %><br />
#   <%= f.datetime_select :preferred %>
#   <%= f.label :alternative %><br />
#   <%= f.datetime_select :alternative %>
# The following steps would fill out the form:
# Lorsque I select "November 23, 2004 11:20" as the "Preferred" data and time
# And I select "November 25, 2004 10:30" as the "Alternative" data and time
Lorsque /^je sélectionne "([^\"]*)" comme la date et heure "([^\"]*)" $/ do |datetime, datetime_label|
  select_datetime(datetime, :from => datetime_label)
end

# Use this step in conjunction with Rail's time_select helper. For example:
# Lorsque I select "2:20PM" as the time
# Note: Rail's default time helper provides 24-hour time-- not 12 hour time. Webrat
# will convert the 2:20PM to 14:20 and Alors select it. 
Lorsque /^je sélectionne "([^\"]*)" comme heure$/ do |time|
  select_time(time)
end

# Use this step Lorsque using multiple time_select helpers on a page or you want to
# specify the name of the time on the form.  For example:
# Lorsque I select "7:30AM" as the "Gym" time
Lorsque /^je sélectionne "([^\"]*)" comme heure "([^\"]*)"$/ do |time, time_label|
  select_time(time, :from => time_label)
end

# Use this step in conjunction with Rail's date_select helper.  For example:
# Lorsque I select "February 20, 1981" as the date
Lorsque /^je sélectionne "([^\"]*)" comme date$/ do |date|
  select_date(date)
end

# Use this step Lorsque using multiple date_select helpers on one page or
# you want to specify the name of the date on the form. For example:
# Lorsque I select "April 26, 1982" as the "Date of Birth" date
Lorsque /^je sélectionne "([^\"]*)" comme date "([^\"]*)"$/ do |date, date_label|
  select_date(date, :from => date_label)
end

Lorsque /^je coche "([^\"]*)"$/ do |field|
  check(field)
end

Lorsque /^je décoche "([^\"]*)"$/ do |field|
  uncheck(field) 
end

Lorsque /^je choisis "([^\"]*)"$/ do |field|
  choose(field)
end

Lorsque /^j attache le fichier "([^\"]*)" à "([^\"]*)"$/ do |path, field|
  attach_file(field, path)
end

Alors /^je devrais voir "(.*)"$/ do |text|
  # response.body.should =~ /#{text}/m
  assert_match /#{text}/m, @response.body
end

Alors /^je ne devrais pas voir "(.*)"$/ do |text|
  # response.body.should_not =~ /#{text}/m
  assert_no_match /#{text}/m, @response.body
end

Alors /^la case "(.*)" devrait être cochée$/ do |label|
  # field_labeled(label).should be_checked
  assert field_labeled(label).checked?
end

Alors /^je devrais être sur (.+)$/ do |page_name|
  assert_equal path_to(page_name), URI.parse(current_url).path
end