# features/logout.feature

Feature: Logout
  As a registered member
  So that I can get back to my life
  I want to logout of the Student-Tutor application

Background: authorization and user in database

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester SUNY| stester@binghamton.edu |
  
  Given I am logged into Student-Tutor

@omniauth_test4
Scenario: logout
  When I press "Log Out"
  Then I will see "Tester SUNY has logged out."  
  And I am on the Student-Tutor Landing Page
  And I will see "Instructions"