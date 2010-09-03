@view @already_reserved
Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "reiko" exists with username: "reiko", role: "student"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a user: "johan" exists with username: "johan", role: "god"

@admin
Scenario: List already reserved classes before a certain date
And a user is logged in as "johan"
And a klass: "18-2" exists with date: "2010-03-18", course: course "ruby", start_time: "12:02"
And an attendance exists with klass: klass "18", student: user "reiko"
And an attendance exists with klass: klass "18-2", student: user "reiko"
When I go to the already reserved page for user: "reiko" on "2010-03-18 12:01"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "3/18(Thursday) - Ruby I - 12:02~15:00"

#This is working during the test phase
@no_time_jump
Scenario Outline: A regular student cannot jump in time
# Given a user is logged in as "<user>"
# And an attendance exists with klass: klass "18", student: user "reiko"
# When I go to the already reserved page for user: "reiko" on "2010-03-17"
# Then I should <view> "3/18(Thursday) - Ruby I - 12:00~15:00"
# Examples:
# | user  | view    |
# | johan | see     |
# | reiko | not see |

@canceled
Scenario Outline: Canceled classes should not show up in already reserved classes unless admin
Given a klass exists with date: "2020-08-30", course: course "ruby"
And an attendance exist with student: user "reiko", klass: that klass, cancel: true
And a user is logged in as "<user>"
When I go to the already reserved page for user: "reiko"
Then I should <view> "8/30(Sunday) - Ruby I - 12:00~15:00"
Examples:
| user  | view    |
| johan | see     |
| reiko | not see |


