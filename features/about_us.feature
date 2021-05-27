Feature: About Us 
  As a user
  I want to open the about us page
  so that I see the information on the application
  
Background: authorization and user in database

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester SUNY| stester@binghamton.edu |
  
  Given I am logged into Student-Tutor
  
  @omniauth_test9
  Scenario:
  Given I am on the about us page
  Then I should see "Project Team: Jacob Ditkoff, Devi Kalidindi, Darren Liu, Viswa Baddula, Thomas Horowitz, Jillian Montgomery"