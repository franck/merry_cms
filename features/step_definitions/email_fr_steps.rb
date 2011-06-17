#Commonly used email steps
#
# To add your own steps make a custom_email_steps.rb
# The provided methods are:
#
# reset_mailer 
# open_last_email
# visit_in_email
# unread_emails_for
# mailbox_for
# current_email
# open_email
# read_emails_for
# find_email

module EmailSpec::Helpers
  def current_email_address
    "franck@test.fr" # Replace with your a way to find your current_email. e.g current_user.email
  end
end
World(EmailSpec::Helpers)


# Use this step to reset the e-mail queue within a scenario.
# This is done automatically before each scenario.
#Given /^(?:a clear email queue|no emails have been sent)$/ do
#  reset_mailer
#end

# Use this step to open the most recently sent e-mail. 
#When /^I open the email$/ do
Lorsque /^j'ouvre l'email$/ do
  open_email(current_email_address)
end

Lorsque /^j'ouvre l'email avec le sujet "(.*)"$/ do |sujet|
  open_email(current_email_address, :with_subject => sujet)
end


#When /^I follow "(.*)" in the email$/ do |link|
Lorsque /^je clique sur le lien "(.*)" dans l'email$/ do |link|
  visit_in_email(link)
end

Alors /^je devrais recevoir (un|\d+) emails?$/ do |amount|  
  amount = 1 if amount == "un"
  assert_equal amount.to_i, unread_emails_for(current_email_address).size
end

Alors /^"([^']*?)" devrait recevoir (\d+) emails?$/ do |address, n|
  assert_equal n.to_i, unread_emails_for(address).size
end

#Then /^"([^']*?)" should have (\d+) emails?$/ do |address, n|
#  mailbox_for(address).size.should == n.to_i
#end

#Then /^"([^']*?)" should not receive an email$/ do |address|
#  find_email(address).should be_nil
#end

Alors /^je devrais voir "(.*)" dans le sujet$/ do |text|  
  current_email.should have_subject(Regexp.new(text))
end

#Then /^I should see "(.*)" in the email$/ do |text|
Alors /^je devrais voir "(.*)" dans l'email$/ do |text|
  #assert_match current_email.body, Regexp.new(text)
  assert_match /#{text}/m, current_email.body
end

#When %r{^"([^']*?)" opens? the email with subject "([^']*?)"$} do |address, subject|
#  open_email(address, :with_subject => subject)
#end

#When %r{^"([^']*?)" opens? the email with text "([^']*?)"$} do |address, text|
#  open_email(address, :with_text => text)
#end

Lorsque /^je clique sur le premier lien dans l'email$/ do
  click_first_link_in_email
end

