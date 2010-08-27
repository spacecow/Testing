Background:
Given a setting exist with name: "main"
And a course: "ruby" exists with name: "Ruby I"
And a user: "johan" exists with username: "johan", role: "god, registrant", language: "en"

@history @cancel @absent
Scenario Outline: Canceled&absent classes should not show up in history unless admin
Given a user: "junko" exists with username: "junko", role: "registrant, student"
And a klass: "15" exists with date: "2010-03-15", course: course "ruby"
And a klass: "19" exists with date: "2010-03-19", course: course "ruby"
And a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a klass: "22" exists with date: "2010-03-29", course: course "ruby"
And an attendance exist with student: user "junko", klass: klass "15", absent: true
And an attendance exist with student: user "junko", klass: klass "18", cancel: true
And an attendance exist with student: user "junko", klass: klass "19"
And a user is logged in as "<user>"
When I browse to the reserve history page for user: "junko" for "03/29～04/03"
Then I should <away> "3/15(Monday) - Ruby I - 12:00~15:00"
And I should <away> "3/18(Thursday) - Ruby I - 12:00~15:00"
And I should see "3/19(Friday) - Ruby I - 12:00~15:00"
Examples:
| user  | away    |
| johan | see     |

# junko not see
