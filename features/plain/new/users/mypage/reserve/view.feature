@view

Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "reiko" exists with role: "student"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a user: "johan" exists with username: "johan", role: "god"

@admin @no_classes
Scenario: View for the admin when there are no classes
Given a user is logged in as "johan"
When I go to the reserve page for user: "reiko"

@admin
Scenario: View of the reserve page for admin, weeks start with the latest week containing a class plus four weeks in the past
And a klass exists with date: "2010-03-11", course: course "ruby"
And a user is logged in as "johan"
When I go to the reserve page for user: "reiko"
Then the "saturday" field should have options "BLANK, 03/15～03/20, 03/08～03/13, 03/01～03/06, 02/22～02/27, 02/15～02/20"

@two_weeks
Scenario Outline: A student can only reserve for 2 weeks ahead
And a klass exists with date: "2010-03-11", course: course "ruby"
And a klass exists with date: "2010-03-25", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "<interval>"
Then I should <week1> "3/11(Thursday) - Ruby I - 12:00~15:00"
And I should <week2> "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should <week3> "3/25(Thursday) - Ruby I - 12:00~15:00"
Examples:
| interval     | week1   | week2   | week3   |
| 03/08～03/13 | see     | not see | not see |
| 03/15～03/20 | not see | see     | not see |
| 03/22～03/27 | not see | not see | see     |

@enrolled_courses
Scenario: A student can only reserve classes, which courses he is enrolled in
Given a course: "rails" exists with name: "Rails II"
And a klass exists with date: "2010-03-19", course: course "rails"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should not see "3/19(Friday) - Rails II - 12:00~15:00"

@already_reserved
Scenario: If a student have reserved a class, he can not reserve it again
Given an attendance exists with student: user "reiko", klass: klass "18"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00"

@pending
Scenario: Sort the classes

@one_instance
Scenario: A student can only see one instance of the same class
Given a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00 3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

@sort
Scenario: Classes should be displayed in order after day and then time interval
And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "12:00", end_time: "13:00"
And a klass exists with date: "2010-03-18", course: course "ruby", start_time: "11:00", end_time: "12:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a klass exists with date: "2010-03-20", course: course "ruby", start_time: "17:00", end_time: "18:00"
And a klass exists with date: "2010-03-19", course: course "ruby", start_time: "09:00", end_time: "13:00"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 11:00~12:00 3/18(Thursday) - Ruby I - 12:00~15:00 3/19(Friday) - Ruby I - 09:00~13:00 3/19(Friday) - Ruby I - 12:00~13:00 3/20(Saturday) - Ruby I - 09:00~13:00 3/20(Saturday) - Ruby I - 17:00~18:00"
