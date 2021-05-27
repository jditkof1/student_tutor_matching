
Then(/^I should see the welcome message$/) do
  expect(page).to have_content("Instructions This is a student tutor pairing service. To use this service, sign in, or sign up with your account, look for a subject and then search for a tutor")
end

Given /the following profiles exist/ do |profiles_table|
  profiles_table.hashes.each do |profile|
    Profile.create! profile
  end 
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create! user
  end 
end

Given /the following authorizations exist/ do |authorizations_table|
  authorizations_table.hashes.each do |authorization|
    Authorization.create! authorization
  end 
end

 Then /^I will see "([^"]*)"$/ do |message|
   #p page.body
   expect(page.body).to have_content(message)
   
 end


# features/step_definitions/movie_steps.rb

Given /I am logged into Student-Tutor/ do
  steps %Q{
    Given I am on the Student-Tutor Landing Page   
    And I press "Register or Login with GitHub"
    And I am on the Student-Tutor Home Page
    }
end
Given /the following subjects exist/ do |subjects_table|
  subjects_table.hashes.each do |subject|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
      Subject.create(subject)
  end
  #fail "Unimplemented"
end

Given /the following schedules exist/ do |schedules_table|
  schedules_table.hashes.each do |schedule|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
      Schedule.create(schedule)
  end
  #fail "Unimplemented"
end

# Then /^I will see "([^"]*)"$/ do |message|
#  puts page.body # <---
#  expect(page.body).to have_content(message)
# end