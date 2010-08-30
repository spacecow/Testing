@view
Background:
Given a setting exists with name: "main"
Given a user: "prince" exists with username: "prince", role: "teacher"
Given a user exists with username: "johan", role: "god"

@student
Scenario: A student should not have an already confirmed page
Given a user is logged in as "johan"
And a user exists with role: "student", name: "Reiko Arikawa"
When I go to the already confirmed page for that user
Then I should see "Reiko Arikawa is not a teacher."

@links
Scenario Outline: Links on the confirm page
Given a user is logged in as "prince"
When I go to the already confirmed page for user: "prince"
And I follow "<link>" within "#top_links"
Then I should be redirected to the <path> page for user: "prince"
Examples:
|link|path|
|Confirm|confirm|
|Already confirmed|already confirmed|

@list @confirmed
Scenario Outline: Only confirmed classes show up at the already confirmed page
Given a user is logged in as "johan"
And a course exists with name: "Ruby I"
And a klass exists with date: "2010-08-20", course: that course
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: <status>
When I go to the already confirmed page for user: "prince" on "2010-08-19"
Then I should <view> "8/20(Friday) - Ruby I - 12:00~15:00"
Examples:
| status | view    |
|      4 | not see |
|     33 | see     |
|      2 | not see |
|      9 | see     |
|     17 | see     |

@list @ahead
Scenario Outline: Only classes ahead in time are listed on the already confirmed page
Given a user is logged in as "johan"
And a course exists with name: "Ruby I"
And a klass exists with date: "2010-08-20", course: that course
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: 33
When I go to the already confirmed page for user: "prince" on "<date>"
Then I should <view> "8/20(Friday) - Ruby I - 12:00~15:00"
Examples:
|       date | view    |
| 2010-08-19 | see     |
| 2010-08-21 | not see |

@pending
Scenario: Only admin can see canceled etc...

@pending
Scenario: Teachers should not be able to jump in time
