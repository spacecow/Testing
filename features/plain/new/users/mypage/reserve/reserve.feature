@reserve
Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "johan" exists with username: "johan", role: "god"
And a user: "reiko" exists with role: "student", name: "Reiko Arikawa", username: "reiko"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"

Scenario: Reserve a class
Given a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
And I press "Reserve"
Then I should see "Successfully reserved class(es)." as notice flash message
And I should see no error flash message
And I should be redirected to the already reserved page for user: "reiko"
And 1 attendances should exist with student: user "reiko", klass: klass "18"
And 1 attendances should exist
And "March 6, 2010" should be selected as date in the select menu

@pending
Scenario: Make email testing work
	
@pending
Scenario: A student should not be able to reserve two classes that overlap in time

@pending
Scenario: After reservation, a mail should go to yoyaku@gakuwarinet.com for confirmation, its going to jsveholm@gmail.com now

@admin @already_reserved
Scenario: An admin cannot reserve a class that already has been reserved
Given a user is logged in as "johan"
And an attendance exists with student: user "reiko", klass: klass "18"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
And I press "Reserve"
Then I should see "Successfully reserved class(es)." as notice flash message
And 1 attendances should exist

@admin @already_reserved @unreserve
Scenario: If a student has reserved a class, admin can unreserve it
Given an attendance exists with student: user "reiko", klass: klass "18"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
And I uncheck "3/18(Thursday) - Ruby I - 12:00~15:00"
And I press "Reserve"
Then 0 attendances should exist

@pending
Scenario: Date follows after reservation

@pending
Scenario: If a student get two instances of the same class, admin cannot unreserve just once

#In order to make this test work, you have to comment out
#reject_already_reserved_classes in the users_controller!
@student @already_reserved @unreserve
Scenario: A student cannot unreserve a reserved class
# Given an attendance exists with student: user "reiko", klass: klass "18"
# And a user is logged in as "reiko"
# When I go to the reserve page for user: "reiko" on "2010-03-06"
# Then 1 attendances should exist
# When I uncheck "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I press "Reserve"
# Then 1 attendances should exist
# And I should see no notice flash message
# And I should see no error flash message
# And I should be redirected to the already reserved page for user: "reiko"
# And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

#In order to make this test work, you have to comment out
#reject_already_reserved_classes in the users_controller!
@student @already_reserved
Scenario: A student cannot reserve a class that he already has reserved
# Given a user is logged in as "reiko"
# And an attendance exists with student: user "reiko", klass: klass "18"
# When I go to the reserve page for user: "reiko" on "2010-03-06"
# Then the "3/18(Thursday) - Ruby I - 12:00~15:00" checkbox should be checked
# When I press "Reserve"
# Then I should see "Successfully reserved class(es)." as notice flash message
# And I should see no error flash message
# And 1 attendances should exist
# And I should be redirected to the already reserved page for user: "reiko"
# And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

#In order to make this test work, you have to comment out
#reject_not_enrolled_courses in the users_controller!
@student @enrolled_courses
Scenario: A student cannot reserve a class, which course he is not enrolled in
# Given a user is logged in as "reiko"
# And a course: "lisp" exists with name: "Lisp I"
# And a klass exists with date: "2010-03-18", course: course "lisp"
# When I go to the reserve page for user: "reiko" on "2010-03-06"
# And I check "3/18(Thursday) - Lisp I - 12:00~15:00"
# And I press "Reserve"
# Then I should see "You can only reserve a class, which course you are enrolled in." as error flash message
# And I should see no notice flash message
# And 0 attendances should exist
# And I should be redirected to the reserve page for user: "reiko"
# And the "3/18(Thursday) - Lisp I - 12:00~15:00" checkbox should not be checked

#In order to make this test work, you have to comment out
#reject_instances_of_already_reserved_classes in the users_controller!
@student @one_instance
Scenario: A student should not be able to reserve a class, which instance he already has reserved
# Given a user is logged in as "reiko"
# And a klass: "18-2" exists with date: "2010-03-18", course: course "ruby"
# And an attendance exists with klass: klass "18-2", student: user "reiko"
# When I go to the reserve page for user: "reiko" on "2010-03-06"
# And 1 attendances should exist
# And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I press "Reserve"
# Then I should see "You can only reserve a class once." as error flash message
# And I should see no notice flash message
# And 1 attendances should exist
# And I should be redirected to the reserve page of user: "reiko"
# And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

# @response
# Scenario Outline: When a reservation is made an email response is sent to the staff in the user's language
# Given a user: "junko" exist with role: "student", language: "ja", name: "Reiko Arikawa"
# And a course: "ruby" is one of user: "junko"'s student_courses
# And a user is logged in as "johan"
# When I go to the reserve page for user: "<user>" on "2010-03-06"
# And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I press "Reserve"
# Then "jsveholm@gmail.com" should receive 1 email
# When "jsveholm@gmail.com" opens the email with subject "<subject>"
# Then I should see "<name>" in the email body
# And I should see "<text>" in the email body	
# Examples:
# | user  | name          | subject                 | text                              |
# | junko | Junko Sumii   | Reservations 3/15～3/20 | 3/18(thu) 12:00～13:00(Ruby beg.) |
# | reiko | Reiko Arikawa | 予約 3/15～3/20         | 3/18(木) 12:00～13:00(Ruby初級)   |
