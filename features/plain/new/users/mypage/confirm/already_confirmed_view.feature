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
