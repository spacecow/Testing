@date
Background:
Given a setting exists with name: "main"
And a user: "johan" exists with username: "johan", role: "god"
And a user: "reiko" exists with username: "reiko", role: "student"
And a user is logged in as "johan"
And a klass exists with date: "2010-09-06"

Scenario: The select date menu should change if the today param is secretly modified
When I go to the already reserved page for user: "reiko" on "2010-08-28"
Then "August 28, 2010" should be selected as date in the select menu

Scenario Outline: The select date should keep its date when the already reserved link is pressed
When I go to the <path> page for user: "reiko" on "2010-08-28"
And I follow "Already Reserved" within "#top_links"
Then "August 28, 2010" should be selected as date in the select menu
Examples:
| path             |
| already reserved |
| reserve          |

Scenario: Change the date on the already reserved page
When I go to the already reserved page for user: "reiko"
And I select "June 13, 2009" as date in the select menu
Then "June 13, 2009" should be selected as date in the select menu

Scenario: The week options should be selected if the today param is secretly modified
When I go to the reserve page for user: "reiko" on "2010-08-28"
Then "09/06～09/11" should be selected in the "saturday" field

Scenario Outline: The select date should keep its date when the reserve link is pressed
When I go to the <path> page for user: "reiko" on "2010-08-28"
And I follow "Reserve" within "#top_links"
Then "09/06～09/11" should be selected in the "saturday" field
Examples:
| path             |
| reserve          |
| already reserved |
