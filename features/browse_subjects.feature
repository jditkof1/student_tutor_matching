Feature:
As a student
I want to search and lookup subjects
So that I can find a tutor for that subject

Background: authorization and user in database  # <---- Add this block

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester Suny| stester@binghamton.edu |
  
  Given the following subjects exist:
  |subjectcode | title | description | create_date |
  |1453 | Economics | Economics in detail by James | 05-12-2021 |
  Given I am logged into Student-Tutor

@omniauth_test5  
Scenario: browse subjects
Then I will see "Browse Subjects"
And I will see "Add subject"

@omniauth_test6
Scenario: list of subjects
Given I am on the Browse Subjects Page
Then I will see "All Subjects"