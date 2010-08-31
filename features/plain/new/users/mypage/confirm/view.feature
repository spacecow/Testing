@view
Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user: "prince" exists with username: "prince", role: "teacher"

@student
Scenario Outline: A student should not have a confirm page
Given a user is logged in as "johan"
And a user exists with role: "student", name: "Reiko Arikawa"
When I go to the <path> page for that user
Then I should see "Reiko Arikawa is not a teacher."
Examples:
| path              |
| confirm           |
| already confirmed |

@links
Scenario Outline: Links on the confirm page
Given a user is logged in as "prince"
When I go to the <path> page for user: "prince"
And I follow "<link>" within "#top_links"
Then I should be redirected to the <path> page for user: "prince"
Examples:
| path              | link              | path              |
| confirm           | Confirm           | confirm           |
| confirm           | Already confirmed | already confirmed |
| already confirmed | Confirm           | confirm           |
| already confirmed | Already confirmed | already confirmed |

@allow-rescue
Scenario Outline: Regular teachers can only see their own confirm page
Given a user: "thomas" exists with role: "observer, teacher"
And a user is logged in as "prince"
When I go to the <path> page of user: "thomas"
Then I should be redirected to the confirm page of user: "prince"
Examples:
| path              |
| confirm           |
| already confirmed |

@no_time_jump
Scenario Outline: A regular teacher cannot jump in time
Given a user is logged in as "prince"
And a course "ruby" exists with name: "Ruby I"
And a klass exists with date: "2010-08-20", course: course "ruby"
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: <status>
When I go to the <path> page for user: "prince" on "2010-08-19"
Then I should not see "8/20(Friday) - Ruby I - 12:00~15:00"
Examples:
| status | path              |
|     33 | already confirmed |
|      4 | confirm           |

@too_late
Scenario Outline: Only classes ahead in time are listed on the confirm page
Given a user is logged in as "johan"
And a course exists with name: "Ruby I"
And a klass exists with date: "2010-08-20", course: that course
And a teaching exists with klass: that klass, teacher: user "prince", status_mask: <status>
When I go to the <path> page for user: "prince" on "<date>"
Then I should <view> "8/20(Friday) - Ruby I - 12:00~15:00"
Examples:
| status | path              |       date | view    |
|     33 | already confirmed | 2010-08-19 | see     |
|     33 | already confirmed | 2010-08-21 | not see |
|      4 | confirm           | 2010-08-19 | see     |
|      4 | confirm           | 2010-08-21 | not see |

# @sort
# Scenario Outline: Classes should be displayed in order after day, time interval
# Given a klass: "18" exists with date: "2010-08-18"
# And a teaching exists with klass: klass "18", teacher: user "prince", status_mask: <status>
# And a klass: "17" exists with date: "2010-08-17"
# And a teaching exists with klass: klass "17", teacher: user "prince", status_mask: <status>
# And a user is logged in as "johan"
# When I go to the <path> page for user: "prince" on "2010-08-15"
# Then I should see "bajs"
# Examples:
# | path              | status |
# | already confirmed |     33 |
# | confirm           |      4 |
