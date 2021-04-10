Feature: Display the landing page

As a user 
I want to open the student-tutor pairing web page
So that I can view the landing page

Scenario: 
 Given I am on the landing page
 Then I should see "Instructions"
 When I follow "Sign-up"
 Then I should see "Student-Tutor Pairing"
 When I follow "Sign-in"
 Then I should see "Student-Tutor Pairing"