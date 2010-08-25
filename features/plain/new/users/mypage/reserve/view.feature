Background:
Given a setting exist with name: "main"
And a user: "reiko" exists with username: "reiko", role: "student, registrant", language: "en", name: "Reiko Arikawa"
And a user: "johan" exists with username: "johan", role: "god, registrant", language: "en", name: "Johan Sveholm"

@view @classes @days
Scenario Outline: View of the reserve page  when there are classes to reserve for different days
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/<date>(<day>) - Ruby I - 12:00~15:00"
Examples:
| date | day       |
|   15 | Monday    |
|   16 | Tuesday   |
|   17 | Wednesday |
|   18 | Thursday  |
|   19 | Friday    |
|   20 | Saturday  |

@view @classes
Scenario: Regular view of the reserve page when there are classes to reserve
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "Reserve" as second title
And I should see "Classes to reserve"
And "03/15～03/20" should be selected in the "saturday" field
And I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "Reservations can be made from Sat 12am to Tue 5pm."

@view @no_classes
Scenario: Reserve View without classes
Given a user is logged in as "johan"
When I browse to the reserve page for user: "reiko"
Then I should see "Reserve" as second title
And I should see "You can do no reservations today."

@view @admin
Scenario: View of the reserve page for admin, weeks start with the latest week containing a class plus four weeks in the past
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-11", course: course "ruby"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko"
Then the "saturday" field should have options "BLANK, 03/15～03/20, 03/08～03/13, 03/01～03/06, 02/22～02/27, 02/15～02/20"

@view @student
Scenario: View of the reserve page for students
Given a user is logged in as "reiko"
When I browse to the reserve page for user: "reiko"
Then I should see "Reserve" as second title
And I should not see a field "saturday"

@view @double
Scenario: Same class should not be displayed double
Given a course: "ruby" exists with name: "Ruby I"
And course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a klass exists with date: "2010-03-18", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should not see "3/18(Thursday) - Ruby I - 12:00~15:00 3/18(Thursday) - Ruby I - 12:00~13:00"

@view @date @admin
Scenario Outline: Change the week for admin
Given a course: "ruby" exists with name: "Ruby I"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass exists with date: "2010-03-18", course: course "ruby"
And a klass exists with date: "<date>", course: course "ruby"
And a user is logged in as "johan"
When I browse to the reserve page for user: "reiko" for "<interval>"
Then I should see "<day> - Ruby I - 12:00~15:00"
And "<interval>" should be selected in the "saturday" field
Examples:
|       date | interval     | day            |
| 2010-03-18 | 03/15～03/20 | 3/18(Thursday) |
| 2010-03-11 | 03/08～03/13 | 3/11(Thursday) |
| 2010-03-04 | 03/01～03/06 | 3/4(Thursday)  |
| 2010-02-25 | 02/22～02/27 | 2/25(Thursday) |
| 2010-02-18 | 02/15～02/20 | 2/18(Thursday) |

