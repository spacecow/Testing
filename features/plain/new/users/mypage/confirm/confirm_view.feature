@view
Background:
Given a setting exists with name: "main"
And a user: "prince" exists with username: "prince", role: "teacher"
And a user: "johan" exists with username: "johan", role: "god"
And a course: "ruby" exists with name: "Ruby I"

@student
Scenario: A student should not have a confirm page
Given a user is logged in as "johan"
And a user exists with role: "student", name: "Reiko Arikawa"
When I go to the confirm page for that user
Then I should see "Reiko Arikawa is not a teacher."

@links
Scenario Outline: Links on the confirm page
Given a user is logged in as "prince"
When I go to the confirm page for user: "prince"
And I follow "<link>" within "#top_links"
Then I should be redirected to the <path> page for user: "prince"
Examples:
| link              | path              |
| Confirm           | confirm           |
| Already confirmed | already confirmed |

Scenario: View for teacher
Given a user is logged in as "johan"
And a klass exists with date: "2010-08-20", course: course "ruby"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: 4
When I go to the confirm page for user: "prince" on "2010-08-19"
Then I should see "8/20(Friday) - Ruby I - 12:00~15:00"

@no_time_jump
Scenario: A regular student cannot jump in time
Given a user is logged in as "prince"
And a klass exists with date: "2010-08-20", course: course "ruby"
And a teaching exists with klass: that klass, teacher: user "prince"
When I go to the confirm page for user: "prince" on "2010-08-19"
Then I should see "You have no classes to confirm"

Scenario: If a teacher is not suggested for a class, it should not show up as confirmable
Given a user is logged in as "prince"
And a klass exists
When I go to the confirm page for user: "prince"
Then I should see "You have no classes to confirm."

@too_late
Scenario: Only classes that lies ahead of a teacher can be confirmed
Given a user is logged in as "johan"
And a klass exists with date: "2010-08-20"
And a teaching exists with klass: that klass, teacher: user "prince"
When I go to the confirm page for user: "prince" on "2010-08-21"
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

@pending
Scenario: Date drop menu

@pending
Scenario: Classes should be displayed in order after day, time interval

@pending
Scenario: Regular teachers can only see their own confirm page
