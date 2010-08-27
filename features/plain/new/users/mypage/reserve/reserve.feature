@reserve

Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "johan" exists with username: "johan", role: "god"
And a user: "reiko" exists with role: "student"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"

Scenario: Reserve a class
Given a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
And I press "Reserve"
Then I should see "Successfully reserved class(es)." as notice flash message
And I should be redirected to the already reserved page for user: "reiko"
And 1 attendances should exist with student: user "reiko", klass: klass "18"
And 1 attendances should exist

# #In order to make this test work, you have to comment out
# #reject_already_reserved_classes in the users_controller!
# @already_reserved
# Scenario: A student cannot reserve a class that he already has reserved
# Given a user is logged in as "johan"
# And an attendance exists with student: user "reiko", klass: klass "18"
# When I browse to the reserve page for user: "reiko" for "03/15～03/20"
# And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I press "Reserve"
# Then I should see "Successfully reserved class(es)." as notice flash message
# And 1 attendances should exist

# #In order to make this test work, you have to comment out
# #reject_not_enrolled_courses in the users_controller!
# @enrolled_courses
# Scenario: A student cannot reserve a class, which course he is not enrolled in
# Given a user is logged in as "johan"
# And a course: "lisp" exists with name: "Lisp I"
# And a klass exists with date: "2010-03-18", course: course "lisp"
# When I browse to the reserve page for user: "reiko" for "03/15～03/20"
# And I check "3/18(Thursday) - Lisp I - 12:00~15:00"
# And I press "Reserve"
# Then I should see "Successfully reserved class(es)." as notice flash message
# And 0 attendances should exist

# #In order to make this test work, you have to comment out
# #reject_duplicates_and_randomize_instances in the users_controller!
# @one_instance
# Scenario: A student should not be able to reserve a class, which instance he already have reserved
# Given a user is logged in as "johan"
# And a klass: "18-2" exists with date: "2010-03-18", course: course "ruby"
# And an attendance exists with klass: klass "18-2", student: user "reiko"
# When I browse to the reserve page for user: "reiko" for "03/15～03/20"
# And 1 attendances should exist
# And I check "3/18(Thursday) - Ruby I - 12:00~15:00"
# And I press "Reserve"
# Then I should see "Successfully reserved class(es)." as notice flash message
# And 1 attendances should exist
