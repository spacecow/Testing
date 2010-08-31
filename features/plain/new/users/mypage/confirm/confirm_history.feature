# @view @history
# Scenario Outline: View of confirm history
# Given a klass: "18" exists with date: "2010-03-18"
# Given a klass: "19" exists with date: "2010-03-19"
# Given a klass: "29" exists with date: "2010-03-29"
# And a teaching exists with klass: klass "18", teacher: user "prince", status_mask: <status>
# And a teaching exists with klass: klass "19", teacher: user "johan", status_mask: 33
# And a teaching exists with klass: klass "29", teacher: user "prince", status_mask: 33
# Given a user is logged in as "johan"
# When I browse to the confirm history page for user: "prince" for "03/29～04/03"
# And I should <view> "3/18(Thursday)"
# And I should not see "3/19(Friday)"
# And I should not see "3/29(Monday)"
# Examples:
# | status | view    |
# |      4 | not see |
# |     33 | see     |
# |      2 | not see |
# |      9 | see     |
# |     17 | see     |

# @pending
# Scenario: Only show classes that have been confirmed taught in the history? (NOT IMPLEMENTED)
