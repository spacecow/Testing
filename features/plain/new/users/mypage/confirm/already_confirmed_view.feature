@view
Background:
Given a setting exists with name: "main"
Given a user: "prince" exists with username: "prince", role: "teacher"
Given a user exists with username: "johan", role: "god"

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

@pending
Scenario: Only classes that has not yet started are listed on the already confirmed page

@pending
Scenario: Only admin can see canceled etc...

@pending
Scenario: Only current...?
