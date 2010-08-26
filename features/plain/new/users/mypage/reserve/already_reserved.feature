Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "junko" exists with username: "junko", role: "registrant, student", language: "en", name: "Junko Sumii"
And a user: "johan" exists with username: "johan", role: "god, teacher, student", language: "en", name: "Johan Sveholm"

@already_reserved
Scenario Outline: If a class exists doubled, the one in use should be displayed
Given course: "ruby" is one of user: "junko"'s student_courses
And a klass: "klass16-1" exists with date: "2010-03-18", course: course "ruby"
And a klass: "klass16-2" exists with date: "2010-03-18", course: course "ruby"
And an attendance exists with student: user "junko", klass: klass "<klass>"
And a user is logged in as "johan"
When I browse to the already reserved page for user: "junko" for "03/15～03/20"
Then I should see "3/18(Thursday) - Ruby I - 12:00~15:00"
Examples:
| klass     |
| klass16-1 |
| klass16-2 | 

@reserved @cancel
Scenario Outline: Canceled classes should not show up in reserved classes unless admin
Given a klass: "19" exists with date: "2010-03-19", course: course "ruby"
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And an attendance exist with student: user "junko", klass: klass "18", cancel: true
And an attendance exist with student: user "junko", klass: klass "19"
And a user is logged in as "<user>"
When I browse to the already reserved page for user: "junko" for "03/15～03/20"
Then I should <canceled> "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "3/19(Friday) - Ruby I - 12:00~15:00"
Examples:
| user  | canceled |
| johan | see      |

# junko not see

@pending
Scenario: Be able to test students who cannot change days
