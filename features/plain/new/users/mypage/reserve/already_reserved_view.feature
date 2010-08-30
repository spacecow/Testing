@view @already_reserved

Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "reiko" exists with username: "reiko", role: "student"
And a course: "ruby" is one of user: "reiko"'s student_courses
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a user: "johan" exists with username: "johan", role: "god"

@teacher
Scenario: A teacher should not have a reserve page
Given a user is logged in as "johan"
And a user exists with role: "teacher", name: "Prince Philip"
When I go to the reserve page for that user
Then I should see "Prince Philip is not a student."

@links
Scenario Outline: Links on the already reserved page
Given a user is logged in as "reiko"
When I go to the already reserved page for user: "reiko"
And I follow "<link>" within "#top_links"
Then I should be redirected to the <path> page for user: "reiko"
Examples:
| link             | path             |
| Reserve          | reserve          |
| Already Reserved | already reserved |

@student
Scenario: List already reserved classes for students
Given a user is logged in as "reiko"
And an attendance exists with klass: klass "18", student: user "reiko"
When I go to the already reserved page for user: "reiko"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"

@admin
Scenario: List already reserved classes before a certain date
And a user is logged in as "johan"
And a klass: "20" exists with date: "2010-03-20", course: course "ruby"
And an attendance exists with klass: klass "18", student: user "reiko"
And an attendance exists with klass: klass "20", student: user "reiko"
When I go to the already reserved page for user: "reiko" on "2010-03-19"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should not see "3/20(Saturday) - Ruby I - 12:00~15:00"
