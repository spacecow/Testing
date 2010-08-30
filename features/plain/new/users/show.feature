@view
Background:
Given a setting exists with name: "main"

Scenario Outline: A student should be redirected to the reserve page
Given a user exist with role: "<role>", username: "username"
And a user is logged in as "username"
When I go to the show page of that user
Then I should be redirected to the <path> page of that user
Examples:
|role|path|
|student|reserve|
|teacher|confirm|
