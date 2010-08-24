Background:
Given a setting exists with name: "main"
And a user: "reiko" exists with username: "reiko", role: "student, registrant", language: "en", name: "Reiko Arikawa"
And a user: "prince" exists with username: "prince", role: "teacher, registrant", language: "en", name: "Prince Philip"
And a user: "adrian" exists with username: "adrian", role: "teacher, student, registrant", language: "en", name: "Adrian"

Scenario: Display for student
Given a user is logged in as "reiko"
When I go to the show page of user "reiko"
Then I should see a button labeled "Reserve"
And I should not see a button labeled "Confirm"

Scenario: Display for teacher
Given a user is logged in as "prince"
When I go to the show page of user "prince"
Then I should not see a button labeled "Reserve"
And I should see a button labeled "Confirm"

Scenario: Display for student&teacher
Given a user is logged in as "adrian"
When I go to the show page of user "adrian"
Then I should see a button labeled "Reserve"
And I should see a button labeled "Confirm"


