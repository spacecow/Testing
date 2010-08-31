@view
Background:
Given a setting exists with name: "main"
And a user: "prince" exists with username: "prince", role: "teacher"
And a user: "johan" exists with username: "johan", role: "god"
And a course: "ruby" exists with name: "Ruby I"

Scenario: View for teacher
Given a user is logged in as "johan"
And a klass exists with date: "2010-08-20", course: course "ruby"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-19"
Then I should see "8/20(Friday) - Ruby I - 12:00~15:00"

Scenario: If a teacher is not suggested for a class, it should not show up as confirmable
Given a user is logged in as "prince"
And a klass exists
When I go to the confirm page for user: "prince"
Then I should see "You have no classes to confirm."

@status
Scenario Outline: Only classes that are unconfirmed can be confirmed
Given a klass exists with date: "2010-03-18"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: <status>
And a user is logged in as "johan"
When I go to the confirm page for user: "prince" on "2010-03-15"
Then I should <view> "3/18(Thursday)"
Examples:
| status | view    |
|      4 | see     |
|     33 | not see |
|      2 | not see |
|      9 | not see |
|     17 | not see |

@not_current
Scenario: If a teaching is not current it should not appear on the confirm page
Given a klass: "18" exists with date: "2010-03-18", course: course "ruby"
And a teaching exists with klass: klass "18", teacher: user "prince", current: false
And a user is logged in as "johan"
When I go to the confirm page for user: "prince" on "2010-03-06"
Then I should not see "3/18(Thursday) - Ruby I - 12:00~15:00"

@pending
Scenario: Date drop menu

@pending
Scenario: Two teachings should not be able to be current at the same time (NOT IMPLEMENTED)

@pending
Scenario: Declined classes are usually NOT current (NOT IMPLEMENTED) see @not_current
