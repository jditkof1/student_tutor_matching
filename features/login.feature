# features/login.feature

Feature: Login
  As a registered member
  So that can see information about movies that interest me
  I want to login to the RottenPotatoes application

Background: authorization and user in database  # <---- Add this block

  Given the following authorizations exist:
  | provider|uid    |user_id|
  | github  |123456 |1      | 
  
  Given the following users exist:
  |name        | email                 |
  |Tester Suny| stester@binghamton.edu |

@omniauth_test3
Scenario: login
  Given I am on the RottenPotatoes Landing Page
  And I press "Register or Login with GitHub"
  Then I will see "Welcome back Tester Suny! You have logged in via github."
  And I will see "Listing Movies"