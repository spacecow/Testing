@confirm
Background:
Given a setting exists with name: "main"
And a user exists with username: "johan", role: "god"
And a user: "prince" exists

Scenario: Confirm a class
Given a user is logged in as "johan"
When I go to the confirm page for user: "prince"
