@date
Background:
Given a setting exists with name: "main"
And a user: "johan" exists with username: "johan", role: "god"
And a user: "prince" exists with username: "prince", role: "teacher"
And a user is logged in as "johan"
And a klass exists with date: "2010-09-06"

Scenario: The select date menu should change if the today param is secretly modified
When I go to the already confirmed page for user: "prince" on "2010-08-28"
Then "August 28, 2010" should be selected as date in the select menu

Scenario Outline: The select date should keep its date when the already confirmed link is pressed
When I go to the <path> page for user: "prince" on "2010-08-28"
And I follow "Already Confirmed" within "#top_links"
Then "August 28, 2010" should be selected as date in the select menu
Examples:
| path              |
| already confirmed |
| confirm           |

Scenario: Change the date on the already confirmed page
When I go to the already confirmed page for user: "prince"
And I select "June 13, 2009" as date in the select menu
Then "June 13, 2009" should be selected as date in the select menu

Scenario: The week options should be selected if the today param is secretly modified
When I go to the confirm page for user: "prince" on "2010-08-28"
#Then "09/06～09/11" should be selected in the "saturday" field

Scenario Outline: The select date should keep its date when the reserve link is pressed
When I go to the <path> page for user: "prince" on "2010-08-28"
And I follow "Confirm" within "#top_links"
#Then "09/06～09/11" should be selected in the "saturday" field
Examples:
| path              |
| confirm           |
| already confirmed |

@pending
Scenario: Implement week field for confirm
